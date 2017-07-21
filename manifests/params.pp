# == Class: logrotate::params
#
# Params class for logrotate module
#
class logrotate::params {
  case $::osfamily {
    'FreeBSD': {
      $configdir     = '/usr/local/etc'
      $root_group    = 'wheel'
      $logrotate_bin = '/usr/local/sbin/logrotate'
      $conf_params = {
        su_group => $default_su_group,
      }
      $base_rules = {
        'wtmp' => {
          path        => '/var/log/wtmp',
          create_mode => '0664',
        },
        'btmp' => {
          path        => '/var/log/btmp',
          create_mode => '0600',
        },
      }
    }
    'Debian': {
      $default_su_group = versioncmp($::operatingsystemmajrelease, '14.00') ? {
        1         => 'syslog',
        default   => undef
      }
      $conf_params = {
        su_group => $default_su_group,
      }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
      $base_rules = {
        'wtmp' => {
          path        => '/var/log/wtmp',
          create_mode => '0664',
        },
        'btmp' => {
          path        => '/var/log/btmp',
          create_mode => '0600',
        },
      }
    }
    'Gentoo': {
      $conf_params = {
        dateext  => true,
        compress => true,
        ifempty  => false,
        mail     => false,
        olddir   => false,
      }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
      $base_rules = {
        'wtmp' => {
          path        => '/var/log/wtmp',
          missingok   => false,
          create_mode => '0664',
          minsize     => '1M',
        },
        'btmp' => {
          path        => '/var/log/btmp',
          create_mode => '0600',
        },
      }
    }
    'RedHat': {
      $conf_params = {
        dateext  => true,
        compress => true,
        ifempty  => false,
        mail     => false,
        olddir   => false,
      }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
      $base_rules = {
        'wtmp' => {
          path        => '/var/log/wtmp',
          missingok   => false,
          create_mode => '0664',
          minsize     => '1M',
        },
        'btmp' => {
          path        => '/var/log/btmp',
          create_mode => '0600',
        },
      }
    }
    'SuSE': {
      $conf_params = {
        dateext  => true,
        compress => true,
        ifempty  => false,
        mail     => false,
        olddir   => false,
      }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
      $base_rules = {
        'wtmp' => {
          path        => '/var/log/wtmp',
          create_mode => '0664',
          missingok   => false,
        },
        'btmp' => {
          path         => '/var/log/btmp',
          create_mode  => '0600',
          create_group => 'root',
        },
      }
      $rule_default = {
        missingok    => true,
        rotate_every => 'monthly',
        create       => true,
        create_owner => 'root',
        create_group => 'utmp',
        rotate       => 99,
        maxage       => 365,
        size         => '400k',
      }
    }
    default: {
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
      $base_rules = {}
      $conf_params = {}
      $rule_default = {
        missingok    => true,
        rotate_every => 'monthly',
        create       => true,
        create_owner => 'root',
        create_group => 'utmp',
        rotate       => 1,
      }
    }
  }
  $cron_daily_hour    = 1
  $cron_daily_minute  = 0
  $cron_hourly_minute = 1
  $config_file        = '/etc/logrotate.conf'
  $logrotate_conf     = "${configdir}/logrotate.conf"
  $root_user          = 'root'
  $rules_configdir    = "${configdir}/logrotate.d"
}
