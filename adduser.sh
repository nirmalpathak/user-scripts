#!/bin/bash
#Script to add users, add them to sudo group, lock thier passwords & add ssh keys as passwords.

# Function for managing users.
user_mgmt(){
	USERS=('user3' 'user4');
	SUDOGROUP="users"
	for U in ${USERS[@]}
	do
		useradd -G $SUDOGROUP $U #Create user & add them to sudoers group.
		#read -p 'Enter SSH public key: ' KEY
		KEY=`cat /home/$U/key.pub` #Get SSH Keys
		#echo $KEY
		usermod -p "`echo $KEY`" $U #Replace password with SSH public keys.
		passwd -l $U #Lock user password.
	done
}

# Run function on remote hosts over SSH.
for h in `cat hosts.txt`
do
	ssh root@$h "`typeset -f`; user_mgmt"
done
