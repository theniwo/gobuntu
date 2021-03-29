# Use the official image as a parent image.
FROM ubuntu:18.04

# Set the working directory.
WORKDIR /root


# Run the command inside your image filesystem.

# Install packets
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get clean
RUN TZ=Europe/Berlin && DEBIAN_FRONTEND=noninteractive apt-get install -y \
byobu \
curl \
fail2ban \
inetutils* \
iproute2 \
less \
locales \
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
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

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

# Set the locale
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8
#RUN locale-gen de_DE.UTF-8

#Final update
RUN apt-get update
RUN apt-get dist-upgrade -y

# Copy the file from your host to your current location. (This has to be done as the last step before running CMD or ENTRYPOINT)
COPY ./content /

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
