FROM jenkins/jenkins

USER root

COPY master_key.pub /home/remote_user/.ssh/authorized_keys
#    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN curl -O https://bootstrap.pypa.io/get-pip.py  && \
    python get-pip.py && \
    pip install ansible --upgrade

USER jenkins
