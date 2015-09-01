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
# and
# https://github.com/fedora-cloud/Fedora-Dockerfiles/tree/f21/ssh

FROM fedora:21

RUN yum update -y && yum upgrade -y

# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
RUN yum install -y xpra rox-filer openssh-server pwgen xserver-xephyr xdm fluxbox xvfb sudo 
# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
#RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Create the directory needed to run the sshd daemon
RUN mkdir /var/run/sshd
#create hostkeys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

#set root login
RUN echo 'root:password' | chpasswd

#expose the sshd port
EXPOSE 22

#add a non-root user
RUN useradd --system --create-home --user-group --uid 1000 --shell /bin/bash railsuser
RUN echo 'railsuser:password' | chpasswd

#add a priviledges and take away root ssh
RUN echo 'railsuser ALL=(ALL) ALL' >> /etc/sudoers
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config

#install firefox and a few others
RUN yum install -y firefox xterm konsole kwalletmanager

#install chrome
#http://www.if-not-true-then-false.com/2010/install-google-chrome-with-yum-on-fedora-red-hat-rhel/
WORKDIR /tmp
RUN echo '[google-chrome]' > /etc/yum.repos.d/google-chrome.repo
RUN echo 'name=google-chrome - \$basearch' >> /etc/yum.repos.d/google-chrome.repo
RUN echo 'baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch' >> /etc/yum.repos.d/google-chrome.repo
RUN echo 'enabled=1' >> /etc/yum.repos.d/google-chrome.repo
RUN echo 'gpgcheck=1' >> /etc/yum.repos.d/google-chrome.repo
RUN echo 'gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' >> /etc/yum.repos.d/google-chrome.repo
RUN yum install -y google-chrome-stable
RUN echo export PATH='$PATH:/opt/google/chrome' >> /etc/bashrc

#add curl for downloads, sudo for installs, and others
RUN yum install -y curl sudo tree

EXPOSE 3000

COPY sw-install-rbenv-fedora.sh /home/railsuser/
COPY verification.sh /home/railsuser/
CMD ["/usr/sbin/sshd", "-D"]
