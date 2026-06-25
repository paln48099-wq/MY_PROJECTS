#!/bin/bash

                                                                

                                                                            
          
        Arguments=$1 



		     LOG() {
		     
		     local USER=$1
			     echo " $(date) : $USER " | sudo tee -a /opt/devops/logs/log.txt
		     
		     
		   }




	   GIT_CHECK(){
	   
	   	     if ! command -v git >/dev/null 2>&1
	             then

		     echo " ERROR !!!  GIT IS NOT INSTALLED ON THIS SERVER
		            PLEASE INSTALL GIT BY USING COMMAND <sudo apt install git> "

		     exit 1 
	             fi

 
                      if [ ! -d ".git" ]
		      then 

			     echo "
			            LOCAL GIT REPOSITORY FOLDER DOESNT EXISTS 
			            PLEASE INITIATE LOCAL GIT BY USING COMMAND <git init> 

				    "

			     exit 1 
		      fi
	   
	             LOCAL_REPO_STATUS=$(git status --porcelain)   # -n checks for non zero string length   &&  --porcelain is used for cleaner output of git status
		      

		     if [ -n "$LOCAL_REPO_STATUS" ] 
		     then 
			     echo "
			            WARNING !!!! ALERT !!!!

			            YOUR LOCAL REPO IS NOT CLEAN

			            YOU  HAVE UNCOMMITED OR MODIFIED CHANGES IN YOUR  LOCAL REPO       
				    
				    "

				      
	                     exit 1
		     fi
	   
	   
	   }





         USER_ENTRY() {                
		      
		       local USERNAME=$1
		       local SECTION=$2
		       local SSH_PUBLIC_KEY=$3
      
		      if [  $# -ne 3 ] 
		      then 
			      echo " ERROR!! PLEASE FILL THE DETAILS AGAIN "

			      echo " USAGE : <username> <section> <ssh_public_key> "

		              exit 1
		      fi


		          echo " PLEASE WAIT FOR FEW SECONDS SYSTEM IS CHECKING FOR THE GIVEN USERNAME: '$USERNAME'  SECTION : '$SECTION' AND VERIFYING THE PROVIDED KEY " 
		       


		      if id "$USERNAME" >/dev/null 2>&1

		      then 
			   echo " USER: "$USERNAME" ALREADY EXIST ON THIS SERVER "
			   
		      else    
			    
			    

      			    sudo useradd -m -s /bin/bash -p '*' "$USERNAME"     # create a passwordless user only access with ssh keys 



			         if ! getent group "devops_team" >/dev/null
		                 then 
		                       sudo groupadd devops_team 
			          fi	


                           
      			    sudo usermod -g devops_team "$USERNAME"


			    sudo delgroup $USERNAME >/dev/null


                                    if ! getent group "PROJECT_CHARLIE" >/dev/null
		                    then 
		                         sudo groupadd PROJECT_CHARLIE 
			            fi	 




			    sudo usermod -aG PROJECT_CHARLIE "$USERNAME"

			      
                              if [ ! -d "/home/$USERNAME/$SECTION" ]
			      then 
				   sudo mkdir -p "/home/$USERNAME/$SECTION"
			      fi	    
			      	      

			       
			     sudo chown -R "$USERNAME":devops_team "/home/$USERNAME"              # -R is used to flow the command to subfolders 


			     echo  " USER : '$USERNAME' IS SUCCESSFULLY LOGGED IN THE SERVER IN THE SECTION : '$SECTION' "  


      		      fi 


                           
		      local SSH_DIR="/home/$USERNAME/.ssh"
		      
		      
		      local SSH_AUTH_FILE="$SSH_DIR/authorized_keys"

		          
		      if [ ! -d "$SSH_DIR" ] 
		      then 
			  sudo mkdir -p "$SSH_DIR"
                       fi 


		       echo "$SSH_PUBLIC_KEY" | sudo tee -a "$SSH_AUTH_FILE" >/dev/null             # /dev/null is used becz "tee" command gives output to the terminal   


		       sudo chmod 700 "$SSH_DIR"

		       sudo chmod 600 "$SSH_AUTH_FILE"
		        
		       sudo chown -R "$USERNAME":devops_team "$SSH_DIR"             



		       


		       echo " SSH_FILE AUTHORIZATION IS ESTABLISHED AND SSH_KEY IS ACTIVE . USE THE SERVER SECURELY " 



                       


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



           

                                                                         # Now we check for the existing directory

                    if [ ! -d "/opt/devops/logs" ]
                    then

	               	sudo mkdir -p  "/opt/devops/logs"
	
                     fi

		     

		                                                              #  Check for the Network Status


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

		     if [ $# -ne 4 ]
		      then 
		           echo " ERROR!! USAGE: ./core_ops.sh <init_login> <username> <section> <ssh_public_key> "
	              exit 1
                      fi 
                    


                USER_ENTRY "$2" "$3" "$4"
		
		     
	         LOG "$2"




	 elif [ "$Arguments" == git_validate ]
	 then 

              if [ $# -ne 1 ]
	      then

		      echo " ERROR !!! USAGE: .core_ops.sh <git_validate> " 

		      exit 1
	      else 
		      GIT_CHECK


	      fi

	

	    
 
             
	else 
            echo " PLEASE ENTER VALID ARGUMENT TO ACCESS "


	    echo "          HELP GUIDE 
	               
	            TO CHECK ENV  >>>>    USAGE : ./core_ops.sh <init_env>

		    TO LOGIN      >>>>    USAGE : ./core_ops.sh <init_login> <username> <section name> <ssh_public_key> 

		    TO VALIDATE GIT >>>>  USAGE : ./core_ops.sh <git_validate> "

	fi



     
             		      




          
	         
	         
             

			    		      
             

























 



                      	     
