pipeline {
  environment {
    CONFIGURATION = 'Debug'
    SCHEMA = "${env.BUILD_SCHEME}"
    APP_CENTER_UPLOAD = "${env.App_Center_Upload}"
	SKIP_SONAR = "${env.SKIP_SONAR}"
    LANG = 'en_US.UTF-8'
    KEYCHAIN_PASSWORD = "${env.KEYCHAIN_PASSWORD}"
    BUILD_NUMBER = "${env.BUILD_NUMBER}"
    EXPORT_METHOD = "${env.EXPORT_METHOD}"
	CHECKOUT_BRANCH_NAME = "${env.GIT_BRANCH}"
  }
  agent {
    node {
      label 'MAC'
    }
  }
  stages {
    stage ('Xcode/Jenkins Set up') {
      steps {
       echo 'Pulling...' + env.GIT_BRANCH
       sh 'sudo xcode-select -switch /Applications/Xcode.app'
       sh 'cd ${WORKSPACE}'
       sh 'pwd'
	   sh 'pod install'
       sh 'bundle exec fastlane jenkins_setup password:$KEYCHAIN_PASSWORD buildNumber:$BUILD_NUMBER'
      }
    }
    stage('Archive & Generate ipa') {
      steps {
        sh 'bundle exec fastlane generate_ipa scheme:$SCHEMA exportMethod:$EXPORT_METHOD'
        archiveArtifacts artifacts: "Builds/*.${BUILD_NUMBER}-*.ipa"
      }
    }

    stage('Upload to appstore') {
      steps {
        sh 'bundle exec fastlane generate_ipa scheme:$SCHEMA exportMethod:$EXPORT_METHOD'
      }
    }
  }
  post {
      failure {
          mail to: 'shivam.vaishnav@gmail.com',
                        subject: 'Build Failed',
                        body: "NYTimes-App; Project: ${env.JOB_NAME}; Build Number: ${env.BUILD_NUMBER}; Build Status: Failed; URL for the build: ${env.BUILD_URL}"
        }

        success {
          mail to: 'shivam.vaishnav@gmail.com',
            subject: 'Build Success',
            body: "NYTimes-App; Project: ${env.JOB_NAME}; Build Number: ${env.BUILD_NUMBER}; Build Status: Success; URL for the build: ${env.BUILD_URL}"
        }
  } 
}
