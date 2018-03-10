# frozen_string_literal: true

#
# Cookbook Name:: yum-nginx
# Recipe:: default
#
#  Installs & configures the yum NGINX repostories.  Any attribute supported by
#  the [yum cookbook](https://github.com/chef-cookbooks/yum#parameters) is
#  supported by this cookbook and can be used to override attributes in this
#  cookbook.

# check is platform is supported
platform_family = node['platform_family']
platform = node['platform']
platform_version = node['platform_version']

raise("#{platform_family}/#{platform}/#{platform_version} is not supported by the default recipe") \
  unless platform_family?('rhel') &&
         node['yum-nginx']['rhel']['supported-versions']
         .select { |_version, is_included| is_included }
         .keys
         .include?(platform_version.to_i.to_s)

node['yum-nginx']['repos'].each do |repo, value|
  next unless value['managed']

  # download the GPG Key and import it if not already installed
  if value['gpgcheck'] && !value['gpgkey'].nil?
    gpgkey_path = File.join(Dir.tmpdir, 'nginx_signing.key')
    cookbook_file File.basename(gpgkey_path) do
      path gpgkey_path
      notifies :run, 'execute[import gpgkey]', :immediately
      only_if "rpm -qi gpg-pubkey-7bd9bf62-* | grep 'not installed'"
    end

    execute 'import gpgkey' do
      command "rpm --import #{gpgkey_path}"
      action :nothing
      only_if "rpm -qi gpg-pubkey-7bd9bf62-* | grep 'not installed'"
    end
  end

  yum_repository repo do
    # define all attributes even though we are not using them all so that the
    #  values can be passed through to override yum repository definitions

    # Attribute Sources:
    #  https://github.com/chef-cookbooks/yum
    #  https://github.com/chef-cookbooks/yum/blob/master/resources/repository.rb

    baseurl value['baseurl'] unless value['baseurl'].nil?
    cost value['cost'] unless value['cost'].nil?
    description value['description'] unless value['description'].nil?
    enabled value['enabled'] unless value['enabled'].nil?
    enablegroups value['enablegroups'] unless value['enablegroups'].nil?
    exclude value['exclude'] unless value['exclude'].nil?
    failovermethod value['failovermethod'] unless value['failovermethod'].nil?
    fastestmirror_enabled value['fastestmirror_enabled'] unless value['fastestmirror_enabled'].nil?
    gpgcheck value['gpgcheck'] unless value['gpgcheck'].nil?
    gpgkey value['gpgkey'] unless value['gpgkey'].nil?
    http_caching value['http_caching'] unless value['http_caching'].nil?
    includepkgs value['includepkgs'] unless value['includepkgs'].nil?
    keepalive value['keepalive'] unless value['keepalive'].nil?
    make_cache value['make_cache'] unless value['make_cache'].nil?
    max_retries value['max_retries'] unless value['max_retries'].nil?
    metadata_expire value['metadata_expire'] unless value['metadata_expire'].nil?
    mirror_expire value['mirror_expire'] unless value['mirror_expire'].nil?
    mirrorlist value['mirrorlist'] unless value['mirrorlist'].nil?
    mirrorlist_expire value['mirrorlist_expire'] unless value['mirrorlist_expire'].nil?
    mode value['mode'] unless value['mode'].nil?
    options value['options'] unless value['options'].nil?
    password value['password'] unless value['password'].nil?
    priority value['priority'] unless value['priority'].nil?
    proxy value['proxy'] unless value['proxy'].nil?
    proxy_username value['proxy_username'] unless value['proxy_username'].nil?
    proxy_password value['proxy_password'] unless value['proxy_password'].nil?
    report_instanceid value['report_instanceid'] unless value['report_instanceid'].nil?
    repositoryid value['repositoryid'] unless value['repositoryid'].nil?
    skip_if_unavailable value['skip_if_unavailable'] unless value['skip_if_unavailable'].nil?
    source value['source'] unless value['source'].nil?
    sslcacert value['sslcacert'] unless value['sslcacert'].nil?
    sslclientcert value['sslclientcert'] unless value['sslclientcert'].nil?
    sslclientkey value['sslclientkey'] unless value['sslclientkey'].nil?
    sslverify value['sslverify'] unless value['sslverify'].nil?
    timeout value['timeout'] unless value['timeout'].nil?
    username value['username'] unless value['username'].nil?
  end
end
