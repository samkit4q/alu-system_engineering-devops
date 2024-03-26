# Puppet manifest to fix Apache returning a 500 error

# Define an exec resource to restart Apache service
exec { 'restart-apache':
  command     => '/usr/sbin/service apache2 restart',
  refreshonly => true,
}

# Define a file resource to update Apache configuration
file { '/etc/apache2/apache2.conf':
  ensure  => file,
  content => template('apache2/apache2.conf.erb'),
  notify  => Exec['restart-apache'],
}

# Define an exec resource to check Apache status
exec { 'check-apache-status':
  command => '/usr/sbin/service apache2 status',
  unless  => '/usr/sbin/service apache2 status | grep -q "Apache2 is running"',
}

# Define an exec resource to check if Apache is serving the correct page
exec { 'check-apache-page':
  command => '/usr/bin/curl -s http://localhost/ | grep -q "Holberton"',
  require => Exec['restart-apache'],
}


