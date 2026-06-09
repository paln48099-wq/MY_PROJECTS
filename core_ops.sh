#!/bin/bash

         #1 : First we check for no. of  arguments
	  
         if [ $# -ne 1 ]
         then 
              
	    echo " usage: ./core_ops.sh < init_env > "

	    exit 1


	 fi 

        #2 : We check for the valid argument 
          
        first_arg=$1 
 
        if [ "$first_arg" == init_env ]         
        then		
       	    echo " HII USER Welcome to this Environment " 



	     
                  if [ "$DEPLOY_ENV" == TESTING ]       # Mistake : Dont Use echo it will empty in someone else env and give syntax error  
	          then 
	              echo " INFO : YOU ARE WORKING IN A TEST SERVER ENVIRONMENT " 
                  else 
                  echo " INFO : YOU ARE USING A SANDBOX ENVIRONMENT " 
                  fi 	     



           

                   #3 : Now we check for the existing directory

                    if [ ! -d "/opt/devops/logs" ]
                    then

	               	sudo mkdir -p  "/opt/devops/logs"
	
                     fi

		   #4 : Check for the Network Status


	            LOCAL_IP=$(hostname -I | awk '{print$1}') 
                   echo " YOUR LOCAL IP ADDRESS IS : $LOCAL_IP" 

	 
	              if  ping -c 3 8.8.8.8 > /dev/null
	             then 
		          echo " YOUR SYSTEM NETWORK INTERFACE IS HEALTHY YOU CAN USE THE SERVER "

                      else 
                      echo " ALERT !!!!! : YOUR SYSTEM NETWORK INTERFACE IS NOT GOOD. ENSURE A GOOD NETWORK CONNECTION "
                      fi 		




 else 
	      echo " Please enter valid ARGUMENT to access "
	      exit 1 
         fi



         	     
