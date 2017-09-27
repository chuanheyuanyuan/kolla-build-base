
###########################################################

#Dockerfile to build docker container images

# Based on centos7.2

############################################################
#Version 1.0

#基础镜像
FROM 172.16.59.153/base/centos:7.2.1511

#维护人
MAINTAINER czwei2@iflytek.com

################### BEGIN INSTALLATION ######################
RUN yum install -y epel-release

RUN yum install -y python-devel libffi-devel openssl-devel gcc python-setuptools git python-pip

RUN git clone http://172.16.59.151:80/czwei2/kolla.git

RUN pip install -U tox

RUN pip install kolla/

WORKDIR  kolla/

RUN pip install -r requirements.txt -r test-requirements.txt

RUN tox -e genconfig



