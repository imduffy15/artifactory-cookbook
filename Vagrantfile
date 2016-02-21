Vagrant.configure('2') do |c|
  c.vm.box = 'centos6'
  c.vm.hostname = 'artifactory.lan.ianduffy.ie'

  c.landrush.host 'centos.direct.mirror.lan.ianduffy.ie', '192.168.254.10'
  c.landrush.host 'fedora.direct.mirror.lan.ianduffy.ie', '192.168.254.10'
  c.landrush.host 'debian.direct.mirror.lan.ianduffy.ie', '192.168.254.10'
  c.landrush.host 'rubygems.direct.mirror.lan.ianduffy.ie', '192.168.254.10'
  c.landrush.host 'supermarket.direct.mirror.lan.ianduffy.ie', '192.168.254.10'
  c.landrush.host 'github.direct.mirror.lan.ianduffy.ie', '192.168.254.10'
  c.landrush.host 'bower.direct.mirror.lan.ianduffy.ie', '192.168.254.10'

  c.landrush.enabled = true
  c.landrush.tld = 'lan.ianduffy.ie'
  c.vm.network 'private_network', ip: '192.168.254.10'

  c.vm.provider :virtualbox do |p|
    p.customize ['modifyvm', :id, '--cpus', '1']
    p.customize ['modifyvm', :id, '--memory', '4096']
  end

  c.vm.provision 'chef_solo' do |chef|
    chef.install = false

    chef.run_list = %w(
      recipe[artifactory::default]
    )
  end
end
