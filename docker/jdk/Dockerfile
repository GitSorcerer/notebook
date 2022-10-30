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