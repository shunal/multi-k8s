docker build -t shunal/multi-client:latest -t shunal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shunal/multi-server:latest -t shunal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shunal/multi-worker:latest -t shunal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shunal/multi-client:latest
docker push shunal/multi-server:latest
docker push shunal/multi-worker:latest
docker push shunal/multi-client:$SHA
docker push shunal/multi-server:$SHA
docker push shunal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shunal/multi-server:$SHA
kubectl set image deployments/client-deployment client=shunal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shunal/multi-worker:$SHA
