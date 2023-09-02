# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:20.04

# 安装依赖
RUN sed -i -E 's/ports.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y curl wget openjdk-8-jdk

# 设置 JAVA_HOME 环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# 下载并安装 Scala 2.11
RUN wget https://downloads.lightbend.com/scala/2.11.12/scala-2.11.12.tgz && \
    tar -xzvf scala-2.11.12.tgz && \
    mv scala-2.11.12 /opt/scala && \
    rm scala-2.11.12.tgz

# 配置 Scala 环境变量
ENV SCALA_HOME=/opt/scala
ENV PATH=$PATH:$SCALA_HOME/bin

# 下载并安装 Maven 3.9.4
RUN wget https://downloads.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz && \
    tar -xzvf apache-maven-3.9.4-bin.tar.gz && \
    mv apache-maven-3.9.4 /opt/maven && \
    rm apache-maven-3.9.4-bin.tar.gz

# 配置 Maven 环境变量
ENV MAVEN_HOME=/opt/maven
ENV PATH=$PATH:$MAVEN_HOME/bin

# 下载并安装 code-server
RUN curl -fOL https://github.com/cdr/code-server/releases/download/v4.16.1/code-server-4.16.1-linux-amd64.tar.gz && \
    tar -xzvf code-server-4.16.1-linux-amd64.tar.gz && \
    mv code-server-4.16.1-linux-amd64 /code-server && \
    rm code-server-4.16.1-linux-amd64.tar.gz

# 暴露 code-server 的默认端口
EXPOSE 8080

# 启动 code-server
CMD ["/code-server/bin/code-server", "--host", "0.0.0.0", "--port", "8080"]
