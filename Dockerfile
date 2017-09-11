
ckerfile to build docker container images

# Based on centos7.2

############################################################
#Version 1.0

#基础镜像
FROM centos:7.2.1611

#维护人
MAINTAINER czwei2@iflytek.com

################### BEGIN INSTALLATION ######################
#yum-repo
RUN yum install -y epel-release

#install 
RUN yum install -y python-pip python-devel libffi-devel openssl-devel gcc python-setuptools git

#docker
RUN yum install docker
RUN pip install docker-py



