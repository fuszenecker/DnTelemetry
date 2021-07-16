docker build -t fuszenecker/dntelemetry:latest .
docker push  fuszenecker/dntelemetry:latest
kubectl delete -f setup.yaml
kubectl apply -f setup.yaml
