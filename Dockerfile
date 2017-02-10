#
#
# SPARK CONTAINER FOR STANDALONE CLUSTER OPERATION
#
# Java: OpenJDK-8-JRE
# Spark: v2.1.0
#
#
# Dockerfile Reference
# https://docs.docker.com/engine/reference/builder/#user
#

FROM openjdk:8-jre

MAINTAINER Tw UxTLi51Nus <TwUxTLi51Nus@posteo.de>

# ENVIRONMENT VARIABLES
ENV SPARK_HOME /opt/spark
ENV PYSPARK_PYTHON python3

# RUN groupadd -r spark && useradd -r -g spark spark
# USER spark

# INSTALL ADDITIONAL REQUIREMENTS
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p "${SPARK_HOME}" && \
    curl "http://www-eu.apache.org/dist/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz" \
         -o spark.tgz && \
    curl "http://www-eu.apache.org/dist/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz.asc" \
         -o spark.tgz.asc && \
    curl https://www.apache.org/dist/spark/KEYS | gpg --import && \
    gpg --verify spark.tgz.asc spark.tgz && \
    tar -xzf spark.tgz -C "${SPARK_HOME}" --strip-components=1 && \
    rm spark.tgz spark.tgz.asc

# JAVA
# JAVA_HOME is already set by the OpenJDK container!
# ENV JAVA_HOME /path/to/java

# EXPOSE PORTS:
# - 8080 for the web ui
# - 7077 is the default master port
EXPOSE 7077 8080

# COPY THE LAUNCH SCRIPT (ENTRYPOINT)
COPY ["launch.sh", "/"]

# ENTRYPOINT
ENTRYPOINT ["/launch.sh"]
CMD ["master"]
