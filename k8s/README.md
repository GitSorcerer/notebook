# k8s 

```yaml
apiVersion: v1
Kind: Pod
metadata: 
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: app
    image: XXXXXXX
```

```shell
# 看查pod相关配置字段
kubectl explain pod.spec
# 根据yaml创建pod
kubectl create -f pod.yaml
# 根据yaml生成pod
kubectl apply -f pod.yaml
# 查看pod信息
kubectl describe pod podname
# 查看pod中的容器
kubectl log podname -c 容器name
# 查看pod列表
kubectl get pod -o wide
```

