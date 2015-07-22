# Class ::cassandra::opscenter::pycrypto
#
# Please see the README for the module for details on usage.
class cassandra::opscenter::pycrypto (
  $ensure       = 'present',
  $manage_epel  = false,
  $package_name = 'pycrypto',
  $provider     = 'pip',
  $reqd_pckgs   = ['python-devel', 'python-pip' ],
  ){
  if $::osfamily == 'RedHat' {
    if $manage_epel == true {
      package { 'epel-release':
        ensure => 'present',
        before => Package[ $reqd_pckgs ]
      }
    }

    package { $reqd_pckgs:
      ensure => present,
      before => Package[$package_name]
    }

    package { $package_name:
      ensure   => $ensure,
      provider => $provider,
      before   => Package['opscenter']
    }
  }
}