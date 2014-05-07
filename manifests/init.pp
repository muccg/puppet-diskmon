class diskmon {

  
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
    content => template("diskmon/hipchat-cli.erb"),
    # notify  => Service['swift-proxy'],
    # require => Package['swift-proxy'],
  }

  file { '/usr/local/bin/swift-check':
    ensure  => file,
    owner   => root,
    group   => root,
    mode   => 755,
    content => template("diskmon/swift-check.erb"),
    # notify  => Service['swift-proxy'],
    # require => Package['swift-proxy'],
  }

  file { '/usr/local/bin/swift-restart':
    ensure  => file,
    owner   => root,
    group   => root,
    mode   => 755,
    content => template("diskmon/swift-restart.erb"),
    # notify  => Service['swift-proxy'],
    # require => Package['swift-proxy'],
  }


  package { 'curl':
    ensure => installed,
  }

  file { '/etc/smartd.conf':
    ensure  => present,
    content => template("diskmon/smartd.conf.erb"),
  }

  file { '/etc/postfix/main.cf':
    ensure  => present,
    content => template("diskmon/main.cf.erb"),
    require => Package['postfix'],
  }

  package { 'smartmontools':
    ensure => installed,
  }

  package { 'postfix':
    ensure => installed,
  }

}
