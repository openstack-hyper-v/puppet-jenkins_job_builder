# == Class: jenkins_job_builder
class jenkins_job_builder (
  $jjb_src_install    = $jenkins_job_builder::params::jjb_src_install,
  $jjb_checkout_dir   = $jenkins_job_builder::params::jjb_checkout_dir,
  $jjb_source_repo    = $jenkins_job_builder::params::jjb_source_repo,
  $jjb_username       = $jenkins_job_builder::params::jjb_username,
  $jjb_token          = $jenkins_job_builder::params::jjb_token,
  $jjb_jenkins_url    = $jenkins_job_builder::params::jjb_jenkins_url,
  $jjb_configfilepath = $jenkins_job_builder::params::jjb_configfilepath,
) inherits jenkins_job_builder::params {

#  if !defined(Package['git']){
#    package { 'git': ensure => present }
#  }
#  if !defined(Package['python-setuptools']){
#    package { 'python-setuptools':
#      ensure  => present,
#      require => Class['python'],
#    }
#  }
  $base_packs = ['PyYAML', 'argparse']
  $packs = str2bool($jjb_src_install) ? {
#   true  => concat($base_packs, ['python-setuptools']),
    true  => concat($base_packs, ['setuptools']),
    false => concat($base_packs, ['jenkins-job-builder']),
  }

  ensure_resource('class', 'python', {'pip' => true })
#  class { 'python':
#    version => 'system',
#    pip     => true,
#  }

  package { $packs:
    ensure   => installed,
    provider => pip,
    require  => Class['python'],
  }

  if str2bool($jjb_src_install) {
    vcsrepo { $jjb_checkout_dir:
      ensure   => latest,
      provider => git,
      source   => $jjb_source_repo,
      revision => 'master',
#      require  => Package['git'],
    }
    exec { 'install_jenkins_job_builder':
      command => 'python setup.py install',
      cwd     => $jjb_checkout_dir,
      path    => $::osfamily ? {
        'windows' => 'c:/windows/system32;c:/windows;c:/python27/bin',
        default   => '/usr/bin',},
      require => [Package[$packs], Vcsrepo[$jjb_checkout_dir]],
      creates => $::osfamily ? {
        'windows' => '',
        default   => '/usr/local/bin/jenkins-jobs',},
    }
  }
  file { $jjb_configfilepath:
    ensure => directory,
  }
  file { "${jjb_configfilepath}/jenkins_jobs.ini":
    ensure  => file,
    content => template('jenkins_job_builder/configfile.erb'),
    require => File[$jjb_configfilepath],
  }
}
