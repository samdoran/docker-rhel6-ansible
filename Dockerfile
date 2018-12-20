FROM registry.access.redhat.com/rhel6
ARG RHSM_USERNAME
ARG RHSM_PASSWORD
ARG RHSM_POOL_ID

ENV CONTAINER=docker

RUN subscription-manager register --username=$RHSM_USERNAME --password=$RHSM_PASSWORD \
    && subscription-manager attach --pool=$RHSM_POOL_ID \
    && yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
    && yum -y install --enablerepo=epel-testing ansible python-jinja2 initscripts sudo cronie \
    && yum -y update \
    && rm -rf /var/cache/yum \
    && subscription-manager unregister

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

RUN echo '# BLANK FSTAB' > /etc/fstab

# Install Ansible inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
