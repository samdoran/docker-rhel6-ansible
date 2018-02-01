FROM registry.access.redhat.com/rhel6
ARG RHN_USERNAME
ARG RHN_PASSWORD
ARG POOL_ID

RUN subscription-manager register --username=$RHN_USERNAME --password=$RHN_PASSWORD \
    && subscription-manager attach --pool=$POOL_ID \
    && yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
    && yum -y --enablerepo=epel-testing install ansible python-jinja2 initscripts sudo cronie \
    && yum -y update \
    && rm -rf /var/cache/yum \
    && subscription-manager unregister

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

RUN echo '# BLANK FSTAB' > /etc/fstab

# Install Ansible inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
