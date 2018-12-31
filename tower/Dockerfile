# Setup a Centos 7 system with Ansible command line tools installed.
FROM centos:7

RUN yum -y install openssh-server

RUN useradd remote_user && \
    echo "1234" | passwd remote_user  --stdin && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY tower_key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user  -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen

RUN yum install -y epel-release && \
    yum install -y ansible

CMD /usr/sbin/sshd -D -e
