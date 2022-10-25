docker pull openjdk:8-jre-slim

docker run --name jdk8 -it 85b121affedd

apt-get update && apt-get install fontconfig -y

docker commit -a "gaoh" -m "openjdk:8-jre-slim,add fontconfig" 2d1b8055804b openjdk-fontconfig:8-jre-slim

docker save -o openjdk-fontconfig.tar openjdk-fontconfig:8-jre-slim

scp -r /resources/images/openjdk-fontconfig.tar  root@10.10.103.70:/resources/images



docker login -u 用户名 -p 密码

docker tag aaa-web:v1 219.139.241.229:8844/aaa/aaa-web:v1

docker push 219.139.241.229:8844/aaa/aaa-web:v1