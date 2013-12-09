# Class:: jenkins_job_builder::params
#
#
class jenkins_job_builder::params {

  $jjb_checkout_dir       = '/opt/src/jenkins_job_builder'
  $jjb_source_repo        = 'git://github.com/openstack-infra/jenkins-job-builder.git'

} # Class:: jenkins_job_builder::params
