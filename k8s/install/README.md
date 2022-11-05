# k8s 安装
## minikube安装
```shell
# 删除之前的
minikube delete
# 启动minikube
# force 以root原型需要携带此参数 
minikube start --driver=docker --force --alsologtostderr -v=1 --image-mirror-country='cn'
```