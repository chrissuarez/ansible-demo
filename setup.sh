#!/bin/bash

# Define the username and password
username="ansible"
password="ansible"

# Create the user
sudo useradd -m $username

# Set the password for the user
echo "$username:$password" | sudo chpasswd


# Create a new user
#sudo useradd -m ansible

# Set password for the user
#sudo passwd newuser

# Add the user to the sudo group
#sudo usermod -aG sudo ansible

sudo touch /etc/sudoers.d/ansible

sudo echo 'echo "ansible ALL=(ALL) NOPASSWS:ALL" >> /etc/sudoers.d/ansible'

sudo chown root:root /etc/sudoers.d/ansible

sudo chmod 440 /etc/sudoers.d/ansible

# Edit sudoers file to allow the user to run sudo without password
#sudo bash -c 'echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

# Switch to the new user
sudo su - ansible

# Generate SSH key for the user
ssh-keygen -t rsa

# Share the public key with the server
ssh-copy-id 192.168.68.103
