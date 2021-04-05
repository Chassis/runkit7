# A class to install runkit7 in Chassis.
class runkit7 (
  $config,
  $php_version  = $config[php]
) {
  if ( ! empty( $config[disabled_extensions] ) and 'chassis/runkit7' in $config[disabled_extensions] ) {
    $package = absent
    $file = absent
  } else {
    $package = latest
    $file = present
  }
  if ! defined(Package['php-pear'] ) {
    package { 'php-pear':
      ensure  => $package,
      require => Package["php${php_version}-fpm", "php${php_version}-cli"],
      notify  => Service["php${php_version}-fpm"],
    }
  }
  if ! defined(Package['php-xml'] ) {
    package { 'php-xml':
      ensure  => $package,
      require => Package["php${php_version}-fpm", "php${php_version}-cli"],
      notify  => Service["php${php_version}-fpm"],
    }
  }
  if ! defined( Package["php${php_version}-dev"] ) {
    package { "php${php_version}-dev":
      ensure  => $package,
      require => Package["php${php_version}-fpm", "php${php_version}-cli"]
    }
  }
  exec { 'install runkit7':
    command => 'pecl install runkit7-alpha',
    require => Package['php-pear', "php${php_version}-dev", 'php-xml', "php${php_version}-fpm", "php${php_version}-cli" ],
    path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
    notify  => Service["php${php_version}-fpm"],
    unless  => 'pecl info runkit7'
  }

  file { "/etc/php/${php_version}/fpm/conf.d/runkit7.ini":
    ensure  => $file,
    content => template('runkit7/runkit7.ini.erb'),
    notify  => Service["php${php_version}-fpm"],
    require => Package["php${php_version}-fpm"]
  }

  file { "/etc/php/${php_version}/cli/conf.d/runkit7.ini":
    ensure  => $file,
    content => template('runkit7/runkit7.ini.erb'),
    require => Package["php${php_version}-cli"]
  }
}
