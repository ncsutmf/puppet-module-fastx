FROM centos:7

ENV PATH="/opt/puppetlabs/puppet/bin:${PATH}"

ARG DEV_USER_ID

RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && yum install -y pdk sudo git ruby ruby-devel rubygems puppet-agent

RUN useradd -u $DEV_USER_ID -m -r developer && \
  echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
USER developer

WORKDIR /opt/fastx
