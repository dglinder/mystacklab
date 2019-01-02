FROM jenkins/jenkins

USER root

#    echo "1234" | passwd remote_user  --stdin && \
RUN useradd remote_user && \
    mkdir -p /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY master_key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user  -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN curl -O https://bootstrap.pypa.io/get-pip.py  && \
    python get-pip.py && \
    pip install ansible --upgrade

USER jenkins
