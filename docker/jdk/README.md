# docker编译jdk8

## 为什么需要编译jdk？

+ 了解Java的核心技术，不仅仅停留在语言使用层面；

+ Jvm是由C++编写的，jdk里面很多库使用了native方法，具体实现也在jvm才能查看；

+ gdb调试Java代码，了解java代码的启动流程；

## 编译说明

> 笔者试过在ubuntu18.4以及centos7下面编译过jdk12，jdk8。当使用win下面的wsl下编译jdk会存在很多问题，但是使用centos编译jdk几乎没啥问题每次都很顺利(**推荐使用centos7进行编译**)。由于笔者已经在win下装好了docker，所以本次直接在docker里面使用centos7编译jdk，jdk则直接在容器里面通过git拉取openjdk源码(从[gitee](https://gitee.com/open-project-github/jdk.git) 中拉取，gitee从[openjdk](https://github.com/openjdk/jdk.git)同步而来)

## 编译准备

### dockerfile

dockerfile里面主要是获取centos7；安装编译jdk所需要的相关依赖以及jdk7；将相关的shell同步到容器，最后执行git_config.sh,拉取代码，开始编译

```dockerfile
#基础镜像使用centos7
FROM centos:centos7

#定义工作目录
ENV WORK_PATH /usr/local

#定义解压缩后的文件名
ENV OPENJDK_SRC_DIR openjdk

#yum更新
RUN yum -y update

#安装工具集
RUN yum -y groupinstall "Development Tools"

#安装用到的软件依赖
RUN yum -y install unzip libXtst-devel libXt-devel libXrender-devel cups-devel freetype-devel alsa-lib-devel which git dos2unix java-1.7.0-openjdk-devel

#复制clone&make的shell
COPY  ./git_config.sh $WORK_PATH/$OPENJDK_SRC_DIR/
COPY  ./start_make.sh $WORK_PATH/$OPENJDK_SRC_DIR/

#如果是在win平台写的shell 在linux可能存在\n换行 需要转换
RUN dos2unix $WORK_PATH/$OPENJDK_SRC_DIR/start_make.sh
RUN dos2unix $WORK_PATH/$OPENJDK_SRC_DIR/git_config.sh

RUN chmod a+x $WORK_PATH/$OPENJDK_SRC_DIR/start_make.sh
RUN chmod a+x $WORK_PATH/$OPENJDK_SRC_DIR/git_config.sh

ENTRYPOINT ["/usr/local/openjdk/git_config.sh"]
```

### 获取jdk

使用git拉去源码，该方式不仅可以编译jdk8,如需编译其他版本的jdk，只需dockerfile中安装对应版本需要的依赖，以及git相应的分支或标签

```shell
#!/bin/bash
cd $WORK_PATH/$OPENJDK_SRC_DIR

# 判断jdk是否clone下来
if [ ! -d "jdk" ];then
  git clone https://gitee.com/open-project-github/jdk.git
  cd jdk
  git checkout jdk8-b120
  mv ../start_make.sh ./
  # 编译jdk
  ./start_make.sh
else
  echo  "jdk is already"
fi

echo "************************************************************************"
echo ""
echo "start git"
echo ""
echo "************************************************************************"

echo "git clone end" > git.txt

# 避免shell执行完毕容器退出
tail -f /dev/null
```

### 编译配置

```shell
#!/bin/bash

chmod a+x ./configure

./configure --with-target-bits=64 --with-debug-level=slowdebug --enable-debug-symbols ZIP_DEBUGINFO_FILES=0

echo "************************************************************************"
echo "************************************************************************"
echo "************************************************************************"
echo ""
echo ""
echo "start make"
echo ""
echo ""
echo "************************************************************************"
echo "************************************************************************"
echo "************************************************************************"

make all CONF=linux-x86_64-normal-server-slowdebug ZIP_DEBUGINFO_FILES=0 DISABLE_HOTSPOT_OS_VERSION_CHECK=OK


echo "make end" > make.txt

# 下面是gdb需要的东西
#yum -y install yum-utils
#debuginfo-install -y glibc-2.17-326.el7_9.x86_64 libgcc-4.8.5-44.el7.x86_64 libstdc++-4.8.5-44.el7.x86_64
```

## 开始编译

```shell
# 生成镜像
docker build -t jdk-build-git:v1 .

# 运行容器
docker run --privileged -itd --name jdk-build-git jdk-build-git:v1

# 查看容器信息
docker attach jdk-build-git

#容器中编译完毕后，进入容器
docker exec -it jdk-build-git /bin/bash

#查看jdk版本
cd /usr/local/openjdk/jdk/build/linux-x86_64-normal-server-slowdebug/jdk/bin/
./java -version
```



### attach信息显示

configure执行成功后会显示以下信息

![](D:\resources\source\notebook\assues\img\config-success.png)

make执行时间较长，耐心等待。成功后会看到以下信息，此时可进入容器进行查看.如果安装完成过后，发现容器关闭了，只需docker start 容器id 后再再进去即可

![](D:\resources\source\notebook\assues\img\docker-build-success.png)

## gdb

### 创建ThreadTest.java

本人比较习惯使用vim，没有依赖install一下就可以了

```java
public class ThreadTest {
    public static void main(String[] args) {
        try {
            new Thread(() -> {
                System.out.println(Thread.currentThread().getName());
            }).start();
        } catch ( Exception e) {
            e.printStackTrace();
        }
    }

}
```

### 编译成class文件

```shell
./javac -g ThreadTest.java
./java ThreadTest
```

### gdb调试

```shell
# gdb执行java
gdb ./java.c

# 设置gdb参数 也就是class文件
set args ThreadTest
# 设置断点
b java.c:187
# 运行
r
# 执行下一行
n
# 显示当前行
l
# 继续执行
c
# 退出
q
```

gdb相关调试参数详情可直接google

### 问题

如果gdb过程出现**debuginfo-install XXXX**,安装缺失的即可

```shell
yum-y install yum-utils
debuginfo-install -y XXXXXX
```

之所以**b java.c:187** 因为main方法入口在**java.c**文件中的**187行**

![](D:\resources\source\notebook\assues\img\gdb-b.png)

## centos编译

如果直接使用centos7进行编译只需将dockerfile中的依赖直接在系统里面安装，然后拉取jdk源码，切到对应分支(标签)，最后编译即可


