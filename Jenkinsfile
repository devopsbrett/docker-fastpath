#!groovy​
properties([[$class: 'jenkins.model.BuildDiscarderProperty', strategy: [$class              : 'LogRotator',
                                                                        numToKeepStr        : '4',
                                                                        artifactNumToKeepStr: '4']]])

node {
  checkout scm
  def REPO = 'brettm/fastpath'
  def GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
  def DEPLOY_TAG = "$REPO:$GIT_COMMIT"

  stage('Build') {
      docker.build(DEPLOY_TAG)
  }

  stage('deploy to dockerhub') {
      withDockerRegistry([credentialsId: 'dockercreds']) {
          docker.image(DEPLOY_TAG).push()
          if(env.BRANCH_NAME == 'develop') {
              docker.image(DEPLOY_TAG).push('latest-snapshot')
          }
          if(env.BRANCH_NAME == 'master') {
              docker.image(DEPLOY_TAG).push('latest')
          }
      }
  }

  stage('env') {
    sh("env")
  }

}