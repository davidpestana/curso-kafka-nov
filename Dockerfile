FROM ubuntu
RUN apt update && apt install -y nano openjdk-8-jdk wget
RUN wget https://downloads.apache.org/kafka/3.6.0/kafka_2.12-3.6.0.tgz && tar zxvf kafka_2.12-3.6.0.tgz && mv kafka_2.12-3.6.0 kafka
WORKDIR /kafka
CMD ["bash"]