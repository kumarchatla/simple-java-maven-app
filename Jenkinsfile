pipeline {
	agent {
		docker {
			image 'maven:3-alpine'
			args '-v /root/.m2:/root/.m2'
		}
	}
	stages {
		stage('Build') {
			steps {
				sh 'mvn -B -DskipTests clean package'
			}
		}
		stage('Test') {
			steps {
				sh 'mvn test'
			}
			post {
				always {
					junit 'target/surefire-reports/*.xml'
				}
			}
		}
		stage('Dependency Check') {
			steps {
				dependencyCheckAnalyzer datadir: 'dependency-check-data', includeVulnReports: true, hintsFile: '', includeCsvReports: false, includeHtmlReports: true, includeJsonReports: false, isAutoupdateDisabled: false, outdir: '', scanpath: '', skipOnScmChange: false, skipOnUpstreamChange: false, suppressionFile: '', zipExtensions: ''
                
    		        	dependencyCheckPublisher canComputeNew: false, defaultEncoding: '', healthy: '', pattern: '', unHealthy: ''

            			archiveArtifacts allowEmptyArchive: true, artifacts: '**/dependency-check-report.html'
                
                    		archiveArtifacts allowEmptyArchive: true, artifacts: '**/dependency-check-report.xml'
			}
		}
		stage('Stage') {
			steps {
				archiveArtifacts allowEmptyArchive: true, artifacts: '**/*.jar'
				sh './jenkins/scripts/deliver.sh'
			}
		}
		stage('Deploy') {
			steps {
				curl --cookie-jar cookie.txt "https://console.deployhub.com/dmadminweb/API/login?user=developer&pass=any"
				curl -b cookie.txt "https://console.deployhub.com/dmadminweb/API/deploy/HelloWorldApp%3B1/GLOBAL.Linux%20Academy.DevSecOps.My%20Pipeline.Development.Dev?task=Deploy%20to%20Dev&wait=n"
			}
		}
	}
}
