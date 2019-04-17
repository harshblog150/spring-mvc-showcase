node {
	
 //stage('Pre-Configure')
 //{
 // sh 'sudo usermod -a -G docker $USER'	 
 //} 
  stage('Cleanup Workspace')
  {
    sh 'echo "Cleanup Workspace before build starts"'
    deleteDir()
  }
  stage('Checkout Source Code') {
   //Checkout Based on Configured Credentials
   sh 'date'
   sh 'pwd' 
   checkout scm
   sh 'git log -n 1'
  }

  stage('Package the war') {
  
  //sh 'docker run --rm -v $WORKSPACE harshblog150/maven:3.6.0-jdk8 mvn package -f $WORKSPACE'
  sh 'mvn package'
  }
 
  stage('Test') {
    junit allowEmptyResults: true, testResults: '**/target/**/TEST*.xml'
  }
  
  stage ('Deploy Application on tomcat Container') {
  //woring part-2 below	  
  sh 'docker run -v $(pwd)/target/spring-mvc-showcase.war:/usr/local/tomcat/webapps/spring-mvc-showcase.war -p 8888:8080 harshblog150/tomcat8:jdk8'
  //working part-1 below
  //sh 'docker run -p 8888:8080 harshblog150/tomcat8:jdk8'
  //sh 'docker cp $(pwd)/target/spring-mvc-showcase.war nostalgic_goldberg:/usr/local/tomcat/webapps/'
  }
}
