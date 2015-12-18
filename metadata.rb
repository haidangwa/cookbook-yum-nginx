name 'yum-nginx'
maintainer 'St. Isidore de Seville'
maintainer_email 'st.isidore.de.seville@gmail.com'
license 'MIT'
description 'Installs/Configures yum NGINX Vendor-Specific Repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.0'

source_url 'https://github.com/st-isidore-de-seville/cookbook-yum-nginx'
issues_url 'https://github.com/st-isidore-de-seville/cookbook-yum-nginx/issues'

recipe 'yum-nginx::default', 'Installs/Configures yum NGINX Vendor-Specific Repository'

depends 'yum', '~> 3.8'

# Supported Platforms:
#  http://nginx.org/en/linux_packages.html
supports 'rhel'
supports 'centos'
