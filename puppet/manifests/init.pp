node default {
  package { "python-virtualenv": ensure => present }
  package { "git": ensure => present }
  package { "vim-enhanced": ensure => present }
  class { 'nginx': }
  include redis

  $host_name = "sangm.io"

  nginx::resource::upstream { 'api.marvelous': 
    members => [ 'localhost:5000']
  }
  nginx::resource::vhost { "${host_name}": www_root => "/var/www/${host_name}/Marvelous" }
  nginx::resource::vhost { "api.${host_name}": proxy => 'http://api.marvelous' }

  file { '/var/www':
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => "755"
  }

  file { '/etc/nginx/sites-enabled/subdomain.marvelous.conf':
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => "server {
  listen                *:80;
  server_name           ~^(?<domain>.+)\.$host_name\$;

  index  index.html index.htm index.php;

  access_log            /var/log/nginx/sangm.io.access.log;
  error_log             /var/log/nginx/sangm.io.error.log;

  location / {
    root      /var/www/templates/\$domain;
  }
}"
  }

  vcsrepo { "/var/www/${host_name}": 
    ensure   => present,
    provider => git,
    source   => "https://github.com/sangm/Team-Yellow.git",
    revision => "recovery",
    owner    => "root",
    group    => "root",
  }  
}
