import java.util.*;
import java.lang.*;

pipeline {

    parameters {
        string defaultValue: 'server1', description: 'Environment', name: 'env_name', trim: true    
    }

    stages("Infra creation") {

        stage ("Read configs") {
            steps {
                script {
                    propertiesFile = readFile "${WORKSPACE}/configs/${env_name}/config.ini"
                }
            }            
        }

        stage ("Create AWS resources") {
            steps {
                script {
                    dir("${WORKSPACE}/terraform") {
                        sh script: """
                            terraform init \\
                                -backend-config="bucket=${tfstatebucket}" \\
                                -backend-config="key=tfstate" \\
                                -backend-config="region=${awsregion}" \\
                        """

                        sh script: """
                            terraform plan \\
                                        -var VPCID="${VPCID}" \\
                                        -var InstanceCount="${InstanceCount}" \\
                        """

                        sh script: """
                            terraform apply -auto-approve\\
                                        -var VPCID="${VPCID}" \\
                                        -var InstanceCount="${InstanceCount}" \\
                        """
                    }
                }
            }
        }

        stage('Configure resources') {
			steps{
				script {
					// some resources config after creation
				}
			}
        }
    }

    post {
        success {
            echo "success"
            // some success email
        }

        failure {
            echo "failure"
			// some success email
        }

        always {
            cleanWs(deleteDirs: true, disableDeferredWipeout:true )
            echo "clean workspace"
        }
    }
}