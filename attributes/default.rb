default['opt-git']['version'] = "2.2.1"
default['opt-git']['download_url'] = "https://github.com/git/git/archive/v#{node['opt-git']['version']}.tar.gz"
default['opt-git']['download_dir'] = "/tmp"
default['opt-git']['prefix'] = "/opt/git-#{node['opt-git']['version']}"
default['opt-git']['packages'] = %w{curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel}
