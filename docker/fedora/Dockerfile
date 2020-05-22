FROM fedora
MAINTAINER joaquin

USER root
RUN yum update -y && yum install -y git wget make
RUN git clone https://github.com/joamatab/install_new_computer
RUN cd install_new_computer && make -f fedora.mk vncserver
RUN bash install fedora.mk
