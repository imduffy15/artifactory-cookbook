name             'artifactory'
maintainer       'Ian Duffy'
maintainer_email 'ian@ianduffy.ie'
license          'apache2'
description      'Installs/Configures artifactory'
long_description 'Installs/Configures artifactory'
version          '0.0.1'

%w(amazon centos fedora oracle redhat scientific).each do |os|
  supports os
end

source_url 'https://github.com/imduffy15/artifactory-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/imduffy15/artifactory-cookbook/issues' if respond_to?(:issues_url)

depends 'yum', '3.10.0'
depends 'java', '1.39.0'
depends 'nginx'
