# == Class: innotop::vars
#
# Figure out which packages need to be installed for innotop based on
# OS.
#
# === Examples
#
#   # To be used in innotop class to ensure the correct packags for
#   # the distro:
#
#   package { $innotop::vars::packages: }
#
# === Authors
#
# Thomas Van Doren
#
# === Copyright
#
# Copyright 2012 Thomas Van Doren, unless otherwise noted
#
class innotop::vars {
  case $::operatingsystem {
    'debian','ubuntu': {
      $packages = ['make',] # 'libdbi-perl', 'libdbd-mysql', 'libterm-readkey-perl',]
    }
    'centos': {
      $packages = ['make', 'perl-DBI', 'perl-DBD-MySQL', 'perl-ExtUtils-MakeMaker', 'perl-TermReadKey',]
    }
    default: {
      fail("This operating system, ${::operatingsystem}, is not supported at this time.")
    }
  }
}
