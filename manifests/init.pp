class jenkins_job_builder (
  $jjb_checkout_dir = $jenkins_job_builder::params::jjb_checkout_dir,
  $jjb_source_repo  = $jenkins_job_builder::params::jjb_source_repo,
) inherits jenkins_job_builder::params {

  package { "git": ensure => present }
  class { 'python': version => 'system', }

  vcsrepo { $jjb_checkout_dir:
    ensure   => latest,
    provider => git,
    source   => $jjb_source_repo,
    revision => "master",
    require  => Package['git'],
  }
  
  exec { 'setup_jenkins_job_builder':
    command     => "python setup.py install",
    cwd         => $jjb_checkout_dir,
    path        => "/usr/bin", 
    require     => [Class['python'], Vcsrepo[$jjb_checkout_dir]],
  }

}

