# Class:: jenkins_job_builder::params
#
#
class jenkins_job_builder::params {

  $jjb_src_install = false
  
  $jjb_checkout_dir = $::osfamily ? {
    'windows' => 'C:/ProgramData/jenkins_job_builder',
    default => '/opt/src/jenkins_job_builder',
  }
#  $jjb_source_repo  = undef
  $jjb_source_repo  = 'git://github.com/openstack-infra/jenkins-job-builder.git'
  
  $jjb_username     = undef
#  $jjb_username     = 'JenkinsJobBuilder'
  $jjb_token        = undef
  $jjb_jenkins_url  = 'http://localhost:8080/'

  $jjb_configfilepath   = $::osfamily ? {
    'windows' => 'C:/ProgramData/jenkins_jobs',
    default => '/etc/jenkins_jobs'
  }

} # Class:: jenkins_job_builder::params
