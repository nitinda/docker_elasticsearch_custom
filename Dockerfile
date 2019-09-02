FROM docker.elastic.co/elasticsearch/elasticsearch:7.3.1

ENV REGION eu-central-1

ADD elasticsearch.yml /usr/share/elasticsearch/config/
USER root

RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

USER elasticsearch
WORKDIR /usr/share/elasticsearch

RUN yes | bin/elasticsearch-plugin install discovery-ec2

RUN yes | bin/elasticsearch-plugin install repository-s3

RUN sed -e '/^-Xm/s/^/#/g' -i /usr/share/elasticsearch/config/jvm.options