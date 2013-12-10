# Class:: jenkins_job_builder::params
#
#
class jenkins_job_builder::params {

  $jjb_checkout_dir = '/opt/src/jenkins_job_builder'
  $jjb_source_repo  = 'git://github.com/openstack-infra/jenkins-job-builder.git'
  
  $jjb_username     = 'JenkinsJobBuilder'
  $jjb_token        = ''
  $jjb_jenkins_url  = 'http://localhost:8080/'

  $jjb_configfile   = '/etc/jenkins_jobs'

} # Class:: jenkins_job_builder::params
