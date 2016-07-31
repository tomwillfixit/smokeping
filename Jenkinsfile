node('build-slave')
{
   
    stage 'Checkout smokeping code'
    checkout scm
    sh 'git clean -fdx'

    stage 'Build smokeping containers'
    dir('.') {
           
        sh 'make build'
       
    }

    stage 'Start smokeping'
    dir('.') {
    
        sh 'make host=localhost start'
    }
 
    stage 'Stop smokeping'
    dir('.') {

            sh 'make stop'
           
        }
   
    stage 'Remove smokeping container'
    dir('.') {
           
            sh 'make clean'
       
    }
   
}

