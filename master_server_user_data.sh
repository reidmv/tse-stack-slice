#!/bin/bash
$version=2016.2.1
curl -O http://pe-releases.puppetlabs.lan/$version/puppet-enterprise-$version-el-7-x86_64.tar.gz
curl -O http://tse-builds.s3-us-west-2.amazonaws.com/2016.2.x/releases/pe-demo-latest.tar.gz
tar -xzf puppet-enterprise-$version-el-7-x86_64.tar.gz
tar -xzf pe-demo-latest.tar.gz
cat > pe.conf <<-EOF
{
  "console_admin_password": "puppetlabs"
  "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
  "puppet_enterprise::use_application_services": true
  "puppet_enterprise::profile::master::r10k_remote": "/opt/puppetlabs/repos/control-repo.git"
  "puppet_enterprise::profile::master::r10k_private_key": "/dev/null"
  "puppet_enterprise::profile::master::code_manager_auto_configure": true
  "puppet_enterprise::profile::master::check_for_updates": false
}
EOF
./puppet-enterprise-$version-el-7-x86_64/puppet-enterprise-installer -c pe.conf
./pe-demo-*/scripts/bootstrap.sh
