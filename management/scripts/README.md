### cert Manager 확인

### Metric Servier 확인

```
kubectl get deployment metrics-server -n kube-system
```

### Calico add-On 확인

```
kubectl get daemonset calico-node --namespace calico-system
```

### Fulent-bit/cloudwatch-agent DaemonSets 확인 / 삭제

```
kubectl -n amazon-cloudwatch get daemonsets
curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluent-bit-quickstart.yaml | sed 's/{{cluster_name}}/'${ClusterName}'/;s/{{region_name}}/'${LogRegion}'/;s/{{http_server_toggle}}/"'${FluentBitHttpServer}'"/;s/{{http_server_port}}/"'${FluentBitHttpPort}'"/;s/{{read_from_head}}/"'${FluentBitReadFromHead}'"/;s/{{read_from_tail}}/"'${FluentBitReadFromTail}'"/' | kubectl delete -f -
```

### Prometheus 확인

```
kubectl get pod -l "app=cwagent-prometheus" -n amazon-cloudwatch
```

### xray-trace 확인 / 로그 보기

```
kubectl describe daemonset xray-daemon
kubectl logs -l app=xray-daemon
```

### 컨트롤러 설치 확인

```
kubectl get deployment -n kube-system aws-load-balancer-controller
```

### autoscaler 로그 확인

```
kubectl -n kube-system logs -f deployment.apps/cluster-autoscaler
```
