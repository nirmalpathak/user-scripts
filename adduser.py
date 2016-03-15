#!/usr/bin/python

#Script to add users, add them to sudo group, lock thier passwords & add ssh keys as passwords.

import os

def user_mgmt(usernames,sgroup):
	for user in usernames:
		os.system("useradd -G %s %s" %(sgroup,user)) #Creating users as sudo group's member.
		#key = raw_input("Enter your SSH public key: ")
		key = open('/home/%s/.ssh/id_rsa.pub' %user, 'r').read().replace('\n', '') #Get SSH Keys
		os.system("usermod -p '%s' %s" %(key,user)) #Replace password with SSH public keys.
		os.system("passwd -l %s" %user) #Lock user password.
		key.close()

user_mgmt(["user1","user2"], 'users')
