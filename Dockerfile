# Use the official image as a parent image.
FROM ubuntu:18.04


ARG BUILD_DATE
ARG NAME
ARG VCS_REF
ARG VERSION

LABEL maintainer="disp@mailbox.org"
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$NAME \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/theniwo/gobuntu" \
      org.label-schema.version=$VERSION

ENV DEBIAN_FRONTEND noninteractive
# Set the working directory.
WORKDIR /root


# Run the command inside your image filesystem.

# Install packets
RUN TZ=America/New_York
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
bash-completion \
byobu \
curl \
fail2ban \
inetutils* \
iproute2 \
less \
locales \
locate \
net-tools \
ntp \
openssh-server \
screen \
sudo \
traceroute \
tzdata \
unattended-upgrades \
vim \
whois

# Set up timezone
#RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# Set up users and passwords
RUN useradd --user-group --create-home --skel /etc/skel --shell /bin/bash user
RUN echo 'root:toor' | chpasswd
RUN echo 'user:userpw' | chpasswd

# Set up ssh process
RUN mkdir /var/run/sshd

# Set up ssh config (#'ed out because we copy the whole file from the host)
#RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
#RUN sed -i 's/#SyslogFacility AUTH/SyslogFacility AUTH/' /etc/ssh/sshd_config
#RUN sed -i 's/#LogLevel INFO/LogLevel INFO/' /etc/ssh/sshd_config
#RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
#RUN echo "SyslogFacility AUTH" >> /etc/ssh/sshd_config
#RUN echo "LogLevel INFO" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Set Variables
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Copy the file from your host to your current location. (This has to be done as the last step before running CMD or ENTRYPOINT)
COPY ./content /

# TODO
# copy readymade locale.gen file to /etc and remove all this steps.
# COPY ./content / has to move up before locale-gen then
# Set the locale to us and german
#RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# pt_PT.UTF-8 UTF-8/pt_PT.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# sv_SE.UTF-8 UTF-8/sv_SE.UTF-8 UTF-8/' /etc/locale.gen
#RUN sed -i -e 's/# sv_FI.UTF-8 UTF-8/sv_FI.UTF-8 UTF-8/' /etc/locale.gen
ENV LANG en_US.UTF-8
ENV LANGUAGE fr:it:es:pt:sv:de:en
RUN locale-gen

# Copy the file from your host to your current location. (This has to be done as the last step before running CMD or ENTRYPOINT)
# COPY ./content /

# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 22

# Run on startup
ENTRYPOINT \
  /usr/sbin/service inetutils-syslogd restart && \
  /usr/sbin/service fail2ban restart && \
  /usr/sbin/service ntp restart && \
  /usr/sbin/service dbus restart && \
  /usr/sbin/sshd -D

# Run the specified command within the container.
CMD ["/usr/sbin/sshd", "-D"]
