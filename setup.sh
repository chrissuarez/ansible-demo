#!/bin/bash

# Set the username for the new Ansible user
username=ansible

# Check if the Ansible user already exists
if ! id "$username" > /dev/null 2>&1; then
	# If the user doesn't exist, create it
	sudo adduser $username
fi

# Check if the entry for the Ansible user already exists in the sudoers file
entry="$username ALL=(ALL) NOPASSWD: ALL"
if ! sudo grep -q "$entry" /etc/sudoers; then
       	#If it doesn't exist, add the entry
      	echo "$entry" | sudo tee -a /etc/sudoers > /dev/null
	echo "Entry added to the sudoers file."
else
    	# If it does exist, don't add the entry
   	echo "Entry already exists in the sudoers file."
fi

# Add the user to the sudo group
sudo usermod -aG sudo $username

# Generate SSH key for the user
sudo -u $username ssh-keygen -t rsa

# Share the public key with the server
sudo -u $username ssh-copy-id 192.168.68.103

# Install Ansible as the Ansible user
sudo -u $username sh -c "sudo apt update && sudo apt install ansible"

