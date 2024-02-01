FROM spark-base

# -- Runtime

ARG spark_worker_web_ui=8081
RUN pip3 install pyarrow torch 
RUN pip3 install torchvision
RUN pip3 install keras
RUN pip3 install scikit-learn tensorflow

EXPOSE ${spark_worker_web_ui}
CMD bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} >> logs/spark-worker.out