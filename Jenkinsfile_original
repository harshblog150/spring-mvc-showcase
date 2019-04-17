node {
  properties([
    parameters([
      string(
        name: 'git_branch_tag_or_commit',
        defaultValue: 'develop',
        description: 'Any branch from https://github.com/HSarode-Compumatrice/spring-mvc-showcase.git'
        ),
      string(
        name: 'deploy_target',
        defaultValue: '',
        description: 'Any environment: dev qa uat prod etc...'
      )
    ])
  ])

  stage('Checkout Codedeploy Branch') {
    sh 'date'
    sh 'pwd'
    sh 'echo git_branch_tag_or_commit=$git_branch_tag_or_commit'
    sh 'echo deploy_target=$deploy_target'
    checkout scm
    sh 'git log -n 1'
  }

  stage('Push archive to S3'){
    sh '''
    aws deploy push \
      --application-name springapp \
      --s3-location s3://springbucket.s3-us-west-2.amazonaws.com/springapp-${BUILD_NUMBER}.zip \
      --source ${PWD} \
	  --region us-west-2
    '''
  }

  withEnv(["PATH=${env.HOME}/tools:${env.PATH}"]) {

  stage('Code Deploy') {
  // Run the codedeploy on ${deploy_target}
      sh '''
      aws deploy create-deployment \
        --application-name springapp \
        --s3-location bucket=springbucket.s3-us-west-2.amazonaws.com,key=springapp-${BUILD_NUMBER}.zip,bundleType=zip \
        --deployment-group-name ${deploy_target} \
        --description "Deployed through Jenkins." \
        --auto-rollback-configuration enabled=false \
        --ignore-application-stop-failures \
        --region us-west-2 \
    '''
   }
  }
  stage('Clean Up Workspace') {
     post {
        always {
            echo 'One way or another, I have finished'
            deleteDir()
        }
    }	
}
