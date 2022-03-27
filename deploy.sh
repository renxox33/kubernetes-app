docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t renxox33/multi-server:latest -t renxox33/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t renxox33/multi-worker:latest -t renxox33/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push stephengrider/multi-client:latest
docker push renxox33/multi-server:latest
docker push renxox33/multi-worker:latest
docker push stephengrider/multi-client:$SHA
docker push renxox33/multi-server:$SHA
docker push renxox33/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=renxox33/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=renxox33/multi-worker:$SHA
