# This Dockerfile builds a workstation that supports a Rails 
# development environment. It comes with SSHD support, Firefox,
# and Chrome. It falls short of installing rails because that 
# is part of the first lab.
#
# The SSHD work shown in this file was derived from
# Roberto Gandolfo Hashioka
# https://github.com/rogaha/docker-desktop/blob/master/Dockerfile
# and
# http://pelle.io/2014/07/11/delivering-gui-applications-with-docker/

FROM ubuntu:14.04.2

RUN apt-get update -y && apt-get upgrade -y

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
RUN apt-get install -y xpra rox-filer openssh-server pwgen xserver-xephyr xdm fluxbox xvfb sudo

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Create the directory needed to run the sshd daemon
RUN mkdir /var/run/sshd

#expose the sshd port
EXPOSE 22

#set root login
RUN echo 'root:password' | chpasswd

# create a non-root user
RUN useradd --system --create-home --user-group --uid 1000 --shell /bin/bash railsuser 
RUN echo 'railsuser:password' | chpasswd

#add sudo to railsuser and take away root ssh
RUN adduser railsuser sudo
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config

#install firefox and a few others
RUN apt-get install -y firefox xterm konsole

#install chrome
WORKDIR /tmp
RUN sudo apt-get install -y libxss1 libappindicator1 libindicator7 gconf-service
RUN sudo apt-get install -y libnspr4 libnss3 fonts-liberation
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN sudo dpkg -i google-chrome*.deb
RUN echo export PATH='$PATH:/opt/google/chrome' >> /etc/bash.bashrc

#add curl for downloads, sudo for installs, and others for rails node.js install
RUN apt-get install -y curl sudo tree

EXPOSE 3000
COPY sw-install-rbenv-ubuntu.sh /home/railsuser/
COPY verification.sh /home/railsuser/
CMD ["/usr/sbin/sshd", "-D"]
