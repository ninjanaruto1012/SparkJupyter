# SparkJupyter

Clone the code on the main branch

git clone https://github.com/ninjanaruto1012/SparkJupyter.git

Assuming that we know how to install docker.
If in Windows, we must install Docker for desktop.
If in Linux, we must install Docker for Ubuntu Linux.

# Apache Spark and JupyterLab
First we must cd to the folder SparkCluster
```s
cd SparkJupyter
```
If it is the first time, we must run each of these command one by one separately

This command to build the image of cluster-base
```s
docker build --network=host -f cluster-base.Dockerfile -t cluster-base .
```

This command to build the image of spark-base
```s
docker build --network=host -f spark-base.Dockerfile -t spark-base .
```

This command to build the image of spark-master
```s
docker build --network=host -f spark-master.Dockerfile -t spark-master .
```

This command to build the image of spark-worker
```s
docker build --network=host -f spark-worker.Dockerfile -t spark-worker .
```

This command to build the image of jupyterlab
```s
docker build --network=host -f jupyterlab.Dockerfile -t jupyterlab .
```

This command to build the image of remote mlflow server
```s
docker build --network=host -f mlflow-remote.Dockerfile -t mlflowremote .
```

This command to build the image of remote mlflow server
```s
docker build --network=host -f mlflow-serve.Dockerfile -t mlflowserve .
```

# Backend

To build the backend which read data from kafka to webservice to frontend
```s
mvn clean package
```
Please note that we must have Maven 3.8.3 and Java 1.8.0_311 for this project

Then we build a docker image with this 
```s
docker build -t kafkawebservice .
```

# Frontend
To build the frontend, we must build the dist from a Angular project
```s
npm run build
```

Then we run the this to build docker
```s
docker build --network=host -t my-dashboard .
```

# Deploy SAAS

Run the following command to check if all images are created properly
```s
docker images
```

Assuming docker compose is installed properly, either for Windows or Linux. We run the following command to launch all images at once
```s
docker compose up -d
```

At this point, you can open Google Chrome on your corporate laptop and typen in http://IP_ADDRESS_OF_LINUX_VM:80/tree to access the jupyterlab.



# Kafka
Pay attention that the docker-compose.yml also include a pack of kakfa, zookeeper and kafka-connect-datagen. After running docker compose up, kakfa will be installed. Once being sure all containers are up and running, we run the follow command to generate data 
```s
curl -X POST -H "Content-Type: application/json" --data @config/connector_pageviews.config http://localhost:8083/connectors
```
Run the following command next to check a sample of data is generated inside kafka
```s
docker-compose exec connect kafka-console-consumer --topic pageviews --bootstrap-server kafka:29092  --property print.key=true --max-messages 5 --from-beginning
```
To have a better visualization of data in Kafka cluster, follow these links to install Kafka tools (now is called Offset)

https://www.baeldung.com/ops/kafka-docker-setup