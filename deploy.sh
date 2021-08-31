docker build -t andreibercea/multi-client:latest -t andreibercea/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andreibercea/multi-server:latest -t andreibercea/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andreibercea/multi-worker:latest -t andreibercea/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push andreibercea/multi-client:latest
docker push andreibercea/multi-server:latest
docker push andreibercea/multi-worker:latest
docker push andreibercea/multi-client:$SHA
docker push andreibercea/multi-server:$SHA
docker push andreibercea/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=andreibercea/multi-client:$SHA
kubectl set image deployments/server-deployment server=andreibercea/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=andreibercea/multi-worker:$SHA
