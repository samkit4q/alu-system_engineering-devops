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

