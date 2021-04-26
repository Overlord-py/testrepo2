#! /bin/bash
clear


function Menu(){
  echo -e "0. Exit\n1. Show all groups\n2. Show group by name\n3. Show all users\n4. Show users by name\n5. Create a new group\n6. Change group\n7. Delete group\n8. Create a new user\n10. Delete user with all directories"
  read choice 

  case "$choice" in
    0) exit=1; echo "Bye!" ;;	  
    1) ShowGroups; ;;
    2) ShowGroupByName; ;;
    3) ShowUsers; ;;
    4) ShowUsersByName; ;;
    5) GroupCreate; ;;
    6) GroupChange; ;;
    7) DeleteGroup; ;;
    8) UserCreate; ;;
    9) UserChange; ;;
    10) UserDelete; ;;
    *) echo "Wrong choice." ;;
  esac
}

function ShowGroupByName(){
  clear

  echo "Enter group name: "
  read groupName
  cat /etc/group | grep $groupName
  echo "============================="

}

function ShowGroups(){
 sudo less /etc/group
}

function ShowUsers(){
 sudo less /etc/passwd
}

function ShowUsersByName(){
 echo "Enter Username to search => "
 read userName
 cat /etc/passwd | grep $userName
 echo "=============================="
}

function GroupCreate(){
 echo -e "1. Create by name\n2. Create ny name + GID "
 read choice
 case "$choice" in
	 1)
	  echo "Enter the name of a new group => "
	  read newgroupName
	  sudo groupadd $newgroupName; ;;
 	 2)
	  echo "Enter the new of a new group =>"
	  read newgroupName
	  echo "Enter the GID => "
 	  read newgroupGID

       	  sudo groupadd $newgroupName -g $newgroupGID; ;;
 esac

}

function GroupChange(){
 echo "Enter a name of Group to change => "
 read group
 echo -e "You want to change:\n1.Name\n2.GID"
 read choice
 case "$choice" in
	 1)
	   echo "Enter a new name for the group => "
 	   read changegroupName
	   sudo groupmod -n $changegroupName $group; ;;
	 2)
	   echo "Enter a new GID for group => "
 	   read newGID
	   sudo groupmod $group -g $newGID; ;;

 esac
}

function DeleteGroup(){
 echo "Enter a group name to delete =>"
 read deleteGroup

 sudo groupdel $deleteGroup
}

function UserCreate(){
 echo -e "You want to add: \n1.Name \n2.Name + UID\n3.Name + GID + UID"
 read choice
 case "$choice" in 
	 1)
	   echo "Enter a username to create => "
	   read newUsername
	   sudo useradd $newUsername; ;;
	 2)
	   echo "Enter a username to create => "
           read newUsername

 	   echo "Enter a new user UID => "
 	   read userUID
	   sudo useradd $newUsername -u $userUID; ;;
	 3)
	   echo "Enter a username to create => "
           read newUsername

	   echo "Enter a new user GID => "
           read userGID
     
	   echo "Enter a new user UID => "
 	   read userUID
	   sudo useradd $newUsername -g $userGID -u $userUID; ;;
 esac
}

function UserChange(){
 echo "Enter a User to change => "
 read username
 echo "You want to change: 1.Username\n2.UID\n3.GID"
 case "$choice" in 
	 1)
	   echo "Enter a new username => "
 	   read changedUsername
	   sudo usermod $changeUsername $username; ;;
	 2)
 	   echo "Enter a new user's new UID"
 	   read userNewUID
	   sudo usermod $username -u $userNewUID; ;;
	 3)
 	   echo "Enter a new user's new GID"
	   read userNewGID
	   sudo usermod $username -g $userNewGID; ;;
 esac
}

function UserDelete(){
 echo "Enter a user to delete => "
 read userdeleteName

 sudo userdel -r -f $userdeleteName

}

let exit=0

while [[ $exit == 0  ]]
do
 Menu;

done
