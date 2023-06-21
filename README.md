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

# How to write script to generate data in VM

First create a directory mon-scripts inside the home/ubuntu folder

```s
mkdir mon-scripts
cat stats.sh
```
create a new file stats.sh
```s
vi stats.sh
```
with the content below
```s
#! /bin/bash
while :
printf "Generating log"
do
TS=$(TZ="EST" date +"%d-%m-%y %r")
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
echo "timestamp: $TS, used_memory: $MEMORY, used_storage: $DISK, used_cpu: $CPU" >> mon-vm.log
sleep 60
done
```
We must assign chmod 777 to the file stats.sh to turn it into executable
```s
chmod 777 stats.sh
```
Now, we will run it forever no hang up by using the following command
```s
nohup ./stats.sh
```
Remember that, after run this command, we must close the window to turn off the session, DO NOT press Ctrl + C here, otherwise it won't work

To kill the process which runs the nohup ./stats.sh forever, we must find the PID
```s
sudo ps -aux | grep stats.sh
```
alwasy look for the right process which has the form /bin/bash ./stats.sh

```s
ubuntu    935765  0.0  0.0   8616  2872 ?        S    Jun09   0:52 /bin/bash ./stats.sh
```
the PID is 935765. Then we use kill -9 to kill it


```s
kill -9 <PID>
```
example: kill -9 2616 where 2616 is PID of admis+ for the command ./stats.sh


