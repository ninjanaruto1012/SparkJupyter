# SparkJupyter

Clone the code on the main branch

git clone https://github.com/ninjanaruto1012/SparkJupyter.git

Assuming that we know how to install docker.
If in Windows, we must install Docker for desktop.
If in Linux, we must install Docker for Ubuntu Linux.

First we must cd to the folder SparkCluster
```s
cd SparkCluster
```
If it is the first time, we must run each of these command one by one separately

This command to build the image of cluster-base
```s
docker build -f cluster-base.Dockerfile -t cluster-base .
```

This command to build the image of spark-base
```s
docker build -f spark-base.Dockerfile -t spark-base .
```

This command to build the image of spark-master
```s
docker build -f spark-master.Dockerfile -t spark-master .
```

This command to build the image of spark-worker
```s
docker build -f spark-worker.Dockerfile -t spark-worker .
```

This command to build the image of jupyterlab
```s
docker build -f jupyterlab.Dockerfile -t jupyterlab .
```

Run the following command to check if all images are created properly
```s
docker images
```

Assuming docker compose is installed properly, either for Windows or Linux. We run the following command to launch all images at once
```s
docker compose up
```