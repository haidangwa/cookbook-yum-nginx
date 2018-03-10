yum-nginx CHANGELOG
=====================

This file is used to list changes made in each version of the yum-nginx
cookbook.

0.3.0
-----
- Dang Nguyen (haidangwa@gmail.com)
  - set default make_cache property of yum repository to true
  - set explicit constraints in Gemfile
  - dropped centos 5 and centos 6 i386 support
  - set chef_version to '> 12.14', '< 14.0' in metadata
  - no longer requires yum cookbook dependency (use chef 12.14's native yum_repository resource)
  - install Chef 13 in Test Kitchen environment
  - Fixed Issue [#8](https://github.com/st-isidore-de-seville/cookbook-yum-nginx/issues/8)
    import GPG key when check GPG key property is enabled
  - updated the nginx.org GPG key embedded in this cookbook
  - enable sslverify on all repos by default
  - Changed default `[baseurl_prefix]` to https://nginx.org

0.2.0
-----
- St. Isidore de Seville (st.isidore.de.seville@gmail.com)
  - fix Chef 13 deprecation warnings
  - fix Chef 11 issues

0.1.0
-----
- St. Isidore de Seville (st.isidore.de.seville@gmail.com)
  - initial release of yum-nginx
