FROM registry.access.redhat.com/rhel6
ARG RHN_USERNAME
ARG RHN_PASSWORD

RUN subscription-manager register --username=$RHN_USERNAME --password=$RHN_PASSWORD --autosubscribe \
    && yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
    && yum -y --enablerepo=epel-testing install ansible python-jinja2 initscripts sudo cronie \
    && yum -y update \
    && yum clean all \
    && subscription-manager unregister

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

# Install Ansible inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
