# JDK

## 调试编译

### 编译jdk8

```shell
yum -y install gcc gcc-c++ kernel-devel
yum -y install gdb

# 安装jdk7 编译需要  建议手动安装 不通过yum  
yum install java-1.7.0-openjdk

yum -y  install zip unzip

yum install libXtst-devel libXt-devel libXrender-devel

yum groupinstall -y "Development Tools"
yum install -y libbXtst-devel libXt-devel libXrender-devel
yum install -y cups-devel
yum install -y alsa-lib-devel
yum install -y freetype-devel
##安装mercurial
yum -y install mercurial
##拉取openjdk8的源码，这种方式拉取比较慢（可以选择下面第二种方案：从github上拉取）
hg clone http://hg.openjdk.java.net/jdk8/jdk8 openjdk8
git clone https://github.com/openjdk/jdk
##拉取后切换分支
cd jdk
##tag 标记 jdk8-b120，github上8版本最新的tag
git checkout jdk8-b120，github上8版本最新的tag 

bash configure --with-target-bits=64 --with-boot-jdk=/usr/local/jdk1.7.0_80 --with-debug-level=slowdebug --enable-debug-symbols ZIP_DEBUGINFO_FILES=0


##检查无误，开始编译
make all CONF=linux-x86_64-normal-server-slowdebug ZIP_DEBUGINFO_FILES=0

```



### 移除yum安装的jdk



先查看 rpm -qa | grep java

显示如下信息：

java-1.4.2-gcj-compat-1.4.2.0-40jpp.115
java-1.6.0-openjdk-1.6.0.0-1.7.b09.el5

卸载：

rpm -e --nodeps java-1.4.2-gcj-compat-1.4.2.0-40jpp.115
rpm -e --nodeps java-1.6.0-openjdk-1.6.0.0-1.7.b09.el5

### gdb调试

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



```shell
./javac -g ThreadTest.java

./java ThreadTest

gdb ./java

gdb:set args ThreadTest
gdb:start
gdb:list
gdb:n
```





```
mkdir notebook
cd notebook
git init
touch README.md
git add README.md
git commit -m "first commit"
git remote add origin https://gitee.com/gaohwh/notebook.git
git push -u origin master
```

## 问题

#### 1.cas修改owner返回值问题

objectMonitor.cpp中332行

ObjectMonitor::enter方法中，在使用CAS修改owner指向的时候返回的是 **NULL** 和  **当前线程Self** 还会是什么

Atomic::cmpxchg_ptr (Self, &_owner, NULL)

#### 2.synchronizer.cpp创建monitor对象先后问题

1250行创建monitor对象为什么不放在cas成功之后

