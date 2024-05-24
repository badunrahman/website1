# Project Documentation: Hosting a Website on DigitalOcean VPS with NGINX and Automated GitHub Deployment

## Table of Contents:
1. Website and GitHub Repo
2. Setting Up the DigitalOcean VPS
3. Connecting to the VPS
4. Installing NGINX and Git
5. Cloning the Website from GitHub
6. Buying and Configuring a Domain with Namecheap
7. Pointing the Domain to the DigitalOcean Droplet
8. Configuring NGINX Root Location
9. Creating a Deploy Script
10. Setting Up Cron Job for Automatic Deployment
11. Testing the Setup

1. Creating a Website and GitHub Repository

Create a Website

Open your code editor (e.g., VSCode) and create a new project. Create a simple website with an `index.html` file and any additional assets you need (e.g., CSS, JS, images).

Initialize a Git Repository

Navigate to your website's directory: 
cd /path/to/your/website

Initialize a Git repository: 
git init

Create a GitHub Repository

Go to GitHub and create a new repository:
- Click on "New Repository."
- Give your repository a name.
- Choose public or private and click on "Create Repository."

Push Your Local Repository to GitHub

Add all files to the repository: 
git add .

Commit the changes: 
git commit -m "Initial commit"

Add the GitHub repository as a remote: 
git remote add origin https://github.com/yourusername/your-repo.git

Push the changes to GitHub: 
git push origin main

**Note**: You may need to generate a personal access token for GitHub if prompted for a password.

2. Setting Up the DigitalOcean VPS

Create a Droplet

Create a DigitalOcean Account:
- Go to DigitalOcean and create an account.

Create a New Droplet:
- Log in to your DigitalOcean account.
- Click on the "Create" button and select "Droplets."
- Choose an image: Select "Ubuntu."
- Choose a plan: Select the appropriate plan based on your needs.
- Choose a datacenter region: Select a location nearest to you.
- Authentication: Add your SSH key or use a password for authentication.
- Finalize and create: Click on "Create Droplet."

3. Connecting to the VPS

Connecting from Mac

Open Terminal: 
ssh root@your_droplet_ip

Connecting from Windows

Using Command Prompt or PowerShell: 
ssh root@your_droplet_ip

4. Installing NGINX and Git

Update the System

Update the package list: 
sudo apt update

Upgrade installed packages: 
sudo apt upgrade

Install NGINX

Install NGINX: 
sudo apt install nginx

Install Git

Install Git: 
sudo apt install git

5. Cloning the Website from GitHub

Navigate to the web directory: 
cd /var/www/html

Clone the GitHub repository: 
sudo git clone https://github.com/yourusername/your-repo.git

6. Buying and Configuring a Domain with Namecheap

Buy a Domain

Go to Namecheap and purchase a domain.

Configure Domain DNS

Go to your Namecheap account.
Navigate to the "Domain List" and click "Manage" next to your domain.
Go to the "Advanced DNS" tab and add an A Record pointing to your Droplet's IP address.

7. Pointing the Domain to the DigitalOcean Droplet

Set Nameservers in Namecheap

In the Namecheap dashboard, under "Domain List" -> "Manage" -> "Nameservers," select "Custom DNS." Add the DigitalOcean name servers:
- `ns1.digitalocean.com`
- `ns2.digitalocean.com`
- `ns3.digitalocean.com`

Configure DNS in DigitalOcean

Go to the DigitalOcean dashboard.
Navigate to "Networking" -> "Domains" and add your domain.
Create A Records pointing your domain and subdomains to your Droplet's IP address.

8. Configuring NGINX Root Location

Navigate to NGINX Configuration Directory

Change directory to NGINX configuration: 
cd /etc/nginx/sites-available

Create a New Configuration File

Open a new configuration file in nano: 
sudo nano /etc/nginx/sites-available/website1

Add the following configuration:

```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    root /var/www/html/website1;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}
Enable the Configuration

Create a symbolic link to enable the site:
sudo ln -s /etc/nginx/sites-available/website1 /etc/nginx/sites-enabled/

Test the NGINX configuration:
sudo nginx -t

Restart NGINX:
sudo systemctl restart nginx

9. Creating a Deploy Script
Create the deploy.sh Script

Open a new script file in nano:
sudo nano /var/www/html/deploy.sh

Add the following script
#!/bin/bash
# Change directory to the website directory
cd /var/www/html/website1
# Reset local changes in the repository
git reset --hard
# Pull latest changes from GitHub and force overwrite local changes
git pull origin main --force
# Restart Nginx to apply changes
systemctl restart nginx


10. Make the Script Executable

Change the script to be executable:
sudo chmod +x /var/www/html/deploy.sh

Setting Up Cron Job for Automatic Deployment
Edit Crontab

Open the crontab file for editing:
sudo crontab -e

Add the following cron job:

/var/www/html/deploy.sh
Testing the Setup
Make some changes to the website. Push the changes to GitHub. Wait one minute and verify that the website updates automatically.




