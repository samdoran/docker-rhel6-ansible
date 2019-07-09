FROM registry.access.redhat.com/rhel6
ARG RHSM_USERNAME
ARG RHSM_PASSWORD
ARG RHSM_POOL_ID

ENV container=docker

RUN subscription-manager register --username=$RHSM_USERNAME --password=$RHSM_PASSWORD \
    && subscription-manager attach --pool=$RHSM_POOL_ID \
    && yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
    && yum -y update \
    && yum -y install \
        ansible \
        cronie \
        initscripts \
        python-jinja2 \
        sudo \
    && rm -rf /var/cache/yum \
    && subscription-manager unregister

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

RUN echo '# BLANK FSTAB' > /etc/fstab

RUN echo -e "localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
