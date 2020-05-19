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
    stage('Lint Podspec') {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          sh 'bundle exec pod lib lint'
        }
      }
    }
  }
}