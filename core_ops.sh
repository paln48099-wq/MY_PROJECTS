#!/bin/bash

                                                                

                                                                            
          
        Arguments=$1 

         USER_ENTRY() {                
		      
		       USERNAME=$1
		       SECTION=$2
      
		      if [  $# -ne 2 ] 
		      then 
			      echo " ERROR!! PLEASE FILL THE DETAILS AGAIN "

			      echo " USAGE : <USERNAME> <SECTION> "

		              exit 1
		     else
		          echo " PLEASE WAIT FOR FEW SECONDS SYSTEM IS CHECKING FOR THE GIVEN USERNAME: '$USERNAME' AND SECTION : '$SECTION' " 
		      fi 


		      if id "$USERNAME" >/dev/null 2>&1

		      then 
			   echo " USER: "$1" ALREADY EXIST ON THIS SERVER "
			   exit 1
		   else    
			    
			    sudo useradd -m  "$USERNAME"       			      
			      
			    sudo usermod -g devops_team "$USERNAME"

			    sudo delgroup $USERNAME

			    sudo usermod -aG PROJECT_CHARLIE "$USERNAME"

			      
                              if [ ! -d "/home/$USERNAME/$SECTION" ]
			      then 
				   sudo mkdir -p "/home/$1/$2"
			      fi	    
			      	      

			       
			     sudo chown "$USERNAME":devops_team "/home/$USERNAME/$SECTION"


			     echo  " USER : '$1' IS SUCCESSFULLY LOGGED IN THE SERVER IN THE SECTION : '$SECTION' "  


		      fi 


		      
		      
		      
		      }






        if [ "$Arguments" == init_env ]         
        then		
       	         if [ $# -ne 1 ] 
		 then
                    echo "Usage: ./core_ops.sh <init_env>"

                    exit 1

                 fi
          
             echo " HII USER WELCOME TO THIS ENVIRONMENT "


	     
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



             elif [ "$Arguments" == init_login ]
	     then

		     if [ $# -ne 3 ]
		      then 
		           echo " ERROR!! USAGE: ./core_ops.sh <init_login> <USERNAME> <SECTION> "
	              exit 1
                      fi 
                    


                USER_ENTRY "$2" "$3"




	else 
            echo " PLEASE ENTER VALID ARGUMENT TO ACCESS "		
	    echo "          HELP GUIDE 
	               
	            TO CHECK ENV  >>>>    USAGE : ./core_ops.sh <init_env>

		    TO LOGIN      >>>>    USAGE : ./core_ops.sh <init_login> <username> <section name> "

	fi



     
             		      




          
	         
	         
             

			    		      
             

























 



                      	     
