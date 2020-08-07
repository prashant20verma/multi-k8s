docker build -t vprashant/multi-client:latest -t vprashant/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vprashant/multi-server:latest -t vprashant/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vprashant/multi-worker:latest -t vprashant/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vprashant/multi-client:latest
docker push vprashant/multi-server:latest
docker push vprashant/multi-worker:latest

docker push vprashant/multi-client:$SHA
docker push vprashant/multi-server:$SHA
docker push vprashant/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vprashant/multi-server:$SHA
kubectl set image deployments/client-deployment client=vprashant/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vprashant/multi-worker:$SHA
