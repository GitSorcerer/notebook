# shell
```shell
scp -r /resources/images root@10.10.103.70:/resources/images
#将文件/resources/images 同步到10.10.103.70:/resources/images
#搜索软件
apt-cache madison make
apt-get install make=version
#修改源
sed -i 's/mirrors.aliyun.com/mirrors.cloud.tencent.com/g' sources.list
#清华大学
sed -i 's/mirrors.cloud.tencent.com/mirrors.tuna.tsinghua.edu.cn/g' sources.list
#中科大
sed -i 's/mirrors.tuna.tsinghua.edu.cn/mirrors.ustc.edu.cn/g' sources.list
#163
sed -i 's/mirrors.ustc.edu.cn/mirrors.163.com/g' sources.list
```