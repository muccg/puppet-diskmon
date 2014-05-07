class gbmon {

  
  package { 'heirloom-mailx':
    ensure => installed,
  }

  service { 'smartd':
    ensure     => running,
    enable     => true,
    subscribe  => [ File['/etc/smartd.conf'] ],
    require => [ Package['smartmontools'], File['/etc/postfix/main.cf'], Package['heirloom-mailx'] ],
  }

  service { 'postfix':
    ensure     => running,
    enable     => true,
    subscribe  => [ File['/etc/postfix/main.cf'] ],
    require => Package['postfix'],
  }


  file { '/usr/local/bin/hipchat-cli':
    ensure  => file,
    owner   => root,
    group   => root,
    mode   => 755,
    content => template("gbmon/hipchat-cli.erb"),
    # notify  => Service['swift-proxy'],
    # require => Package['swift-proxy'],
  }

  file { '/usr/local/bin/swift-check':
    ensure  => file,
    owner   => root,
    group   => root,
    mode   => 755,
    content => template("gbmon/swift-check.erb"),
    # notify  => Service['swift-proxy'],
    # require => Package['swift-proxy'],
  }

  file { '/usr/local/bin/swift-restart':
    ensure  => file,
    owner   => root,
    group   => root,
    mode   => 755,
    content => template("gbmon/swift-restart.erb"),
    # notify  => Service['swift-proxy'],
    # require => Package['swift-proxy'],
  }


  package { 'curl':
    ensure => installed,
  }

  file { '/etc/smartd.conf':
    ensure  => present,
    content => template("gbmon/smartd.conf.erb"),
  }

  file { '/etc/postfix/main.cf':
    ensure  => present,
    content => template("gbmon/main.cf.erb"),
    require => Package['postfix'],
  }

  package { 'smartmontools':
    ensure => installed,
  }

  package { 'postfix':
    ensure => installed,
  }

}
