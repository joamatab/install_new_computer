FROM fedora
MAINTAINER joaquin

USER root
EXPOSE 5901

RUN yum update -y && yum install -y git wget make
RUN git clone https://github.com/joamatab/install_new_computer && cd install_new_computer && make -f fedora.mk vncserver
# RUN cd install_new_computer && bash install fedora.mk

RUN useradd -ms /bin/bash j
USER j
WORKDIR /home/j
# CMD vncserver && tail -f /dev/null
