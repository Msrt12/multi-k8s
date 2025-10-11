docker build -t mstr12/multi-client:latest -t mstr12/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t mstr12/multi-server:latest -t mstr12/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t mstr12/multi-worker:latest -t mstr12/multi-worker:$GIT_SHA  -f ./worker/Dockerfile ./worker

docker push mstr12/multi-client:latest
docker push mstr12/multi-server:latest
docker push mstr12/multi-worker:latest

docker push mstr12/multi-client:$GIT_SHA
docker push mstr12/multi-server:$GIT_SHA
docker push mstr12/multi-worker:$GIT_SHA


kubectl apply -f k8s


kubectl set image deployments/server-deployment server=mstr12/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment web=mstr12/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=mstr12/multi-worker:$GIT_SHA
