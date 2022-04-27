docker build -t codfishjoe/multi-client-k8s:latest -t codfishjoe/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t codfishjoe/multi-server-k8s-pgfix:latest -t codfishjoe/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t codfishjoe/multi-worker-k8s:latest -t codfishjoe/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push codfishjoe/multi-client-k8s:latest
docker push codfishjoe/multi-server-k8s-pgfix:latest
docker push codfishjoe/multi-worker-k8s:latest

docker push codfishjoe/multi-client-k8s:$SHA
docker push codfishjoe/multi-server-k8s-pgfix:$SHA
docker push codfishjoe/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=codfishjoe/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=codfishjoe/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=codfishjoe/multi-worker-k8s:$SHA