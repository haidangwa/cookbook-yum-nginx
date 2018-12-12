# frozen_string_literal: true

name 'new-yum-nginx'
maintainer 'Dang H. Nguyen'
maintainer_email 'haidangwa@gmail.com'
license 'MIT'
description 'Installs/Configures yum NGINX Vendor-Specific Repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

source_url 'https://github.com/haidangwa/cookbook-yum-nginx'
issues_url 'https://github.com/haidangwa/cookbook-yum-nginx/issues'

recipe 'yum-nginx::default', 'Installs/Configures yum NGINX Vendor-Specific Repository'

# Supported Platforms:
#  http://nginx.org/en/linux_packages.html
supports 'redhat', '>= 6.0'
supports 'centos', '>= 6.0'
chef_version '> 12.14'
