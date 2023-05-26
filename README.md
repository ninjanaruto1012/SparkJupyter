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

Run the following command to check if all images are created properly
```s
docker images
```

Assuming docker compose is installed properly, either for Windows or Linux. We run the following command to launch all images at once
```s
docker compose up -d
```

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