# k8s yaml

*rs操作*
```shell
# 通过yaml创建pod
kubectl create -f k8s/yaml/rs.yaml
# 删除所有pod
kubectl delete pod --all
#删除rs
kubectl delete rs --all
#获取所有pod信息
kubectl get pod
#修改podname的tier
kubectl label pod [podname] tier=frontend1
```

deployment
```shell
kubectl apply -f k8s/yaml/deployment.yaml --record

kubectl get deployment
# 获取pod信息
kubectl get pod -o wide
# 对nginx-deployment进行扩容
kubectl scale deployment nginx-deployment --replicas 10
# 自动扩展
kubectl autoscale deployment nginx-deployment --min=10 --max=15 --cpu-percent=80
# 更新deployment下面的nginx-deployment镜像
kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
#回滚
kubectl rollout undo deployment/nginx-deployment
#编辑 Deployment
kubectl edit deployment/nginx-deployment deployment "nginx-deployment" edited

```