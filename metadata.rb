# frozen_string_literal: true

name 'new-yum-nginx'
maintainer 'Dang H. Nguyen'
maintainer_email 'haidangwa@gmail.com'
license 'MIT'
description 'Installs/Configures yum NGINX Vendor-Specific Repository'
version '0.3.1'

source_url 'https://github.com/haidangwa/cookbook-yum-nginx'
issues_url 'https://github.com/haidangwa/cookbook-yum-nginx/issues'

# Supported Platforms:
#  http://nginx.org/en/linux_packages.html
supports 'redhat', '>= 6.0'
supports 'centos', '>= 6.0'
chef_version '>= 13.11'
