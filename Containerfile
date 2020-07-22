FROM registry.access.redhat.com/rhel6

ENV container=docker

RUN yum -y install \
        less \
        libselinux-python \
        initscripts \
        python-python-devel \
        python-python-pip \
        python-python-setuptools \
        python-python-wheel \
        selinux-policy-targeted \
        sudo \
        vim && \
    rm -rf /var/cache/yum

RUN pip install ansible q

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

RUN echo '# BLANK FSTAB' > /etc/fstab

RUN mkdir -p /etc/ansible && \
    echo -e "localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
