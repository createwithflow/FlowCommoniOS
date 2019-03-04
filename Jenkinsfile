pipeline {
  agent any
  stages {
    stage('bundle install') {
      steps {
        sh 'bundle update fastlane'
        sh 'bundle install'
      }
    }
    stage('Build & Test') {
      steps {
      	timeout(time: 10, unit: 'MINUTES') {
        	sh 'bundle exec fastlane test'
       	}
      }
    }
  }
}