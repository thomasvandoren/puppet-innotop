# == Class: innotop
#
# Install innotop and dependencies.
#
# === Examples
#
#   include innotop
#
# === Authors
#
# Thomas Van Doren
#
# === Copyright
#
# Copyright 2012 Thomas Van Doren, unless otherwise noted
#
class innotop {
  include innotop::vars
  package { $innotop::vars::packages:
    ensure => present,
  }
  file { '/tmp':
    ensure => directory,
  }
  file { 'innotop-1.8.1.tar.gz':
    ensure => present,
    path   => '/tmp/innotop.tar.gz',
    source => 'puppet:///modules/innotop/innotop-1.8.1.tar.gz',
  }
  exec { 'innotop-unpack':
    command => '/bin/tar -xzf innotop.tar.gz',
    cwd     => '/tmp',
    creates => '/tmp/innotop-1.8.1',
    require => File['innotop-1.8.1.tar.gz'],
  }
  exec { 'innotop-makefile':
    command => '/usr/bin/perl Makefile.PL',
    cwd     => '/tmp/innotop-1.8.1',
    creates => '/tmp/innotop-1.8.1/Makefile',
    require => Exec['innotop-unpack'],
  }
  exec { 'innotop-install':
    command => '/usr/bin/make install',
    cwd     => '/tmp/innotop-1.8.1',
    creates => '/usr/local/bin/innotop',
    require => Exec['innotop-makefile'],
  }
}
