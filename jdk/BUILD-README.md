# jdk8-bulid

## 获取jdk源码
### 安装git
```shell
apt install -y git
```
### 拉取jdk源码，并切到jdk8最新标签
```shell
# 从gitee上获取同步的jdk，防止github访问过慢
git clone https://gitee.com/open-project-github/jdk.git
# 切到jdk8最后一个标签
git checkout jdk8-b120
# 创建分支
git checkout -b jdk8-ubuntu18
```

## docker build
```shell
apt install -y zip unzip

docker build -t bolingcavalryopenjdk:0.0.1 .
docker run --privileged --name=jdk8-docker-build -idt bolingcavalryopenjdk:0.0.1
docker exec -it jdk001 /bin/bash
cd /usr/local/openjdk
./start_make.sh
```
