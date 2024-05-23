Project Documentation: Hosting website on DigitalOcean VPS with NGINX and Automated GitHub Deployment
Table of Contents:

Website and github repo
Setting up the DigitalOceans VPS : creating a droplet
Connecting to the VPS : connecting from mac ( because i used it but should be same for windows)
Installing NGINX and GIT
Cloning the website from the github
Buying and configuring a domain with namecheap
Pointing the domain to the digitalocean droplet
Configuring NGINX root locating
Creating a deploy script
Setting up cron job for automatic deployment
And test in the end if working 

1. Creating a Website and GitHub Repository
Create a Website
Open your code editor (e.g., VSCode) and create a new project:
Create a simple website with an index.html file and any additional assets you need (e.g., CSS, JS, images).
Initialize a Git Repository:
Cd your website path and then // git init
Create a GitHub Repository
Go to GitHub and create a new repository:
Click on "New Repository."
Give your repository a name
Choose public or private and click on "Create Repository."
Push Your Local Repository to GitHub:
Git add .
Git commit -m “commit’
Git remote add origin https: your github repo link
Git push origin main
Also have to generate a token for password in github in setting and developer option and then create a token and copy it which can be used as password
2. Setting Up the DigitalOcean VPS
Create a Droplet
Create a DigitalOcean Account:
Go to DigitalOcean and create an account.
Create a New Droplet:
Log in to your DigitalOcean account.
Click on the "Create" button and select "Droplets."
Choose an image: Select "Ubuntu."
Choose a plan: Select the appropriate plan based on your needs.
Choose a datacenter region: Select a location nearest to you.
Authentication: Add your SSH key or use a password for authentication.
Finalize and create: Click on "Create Droplet."
3. Connecting to the VPS
Connecting from Mac
Open Terminal: ssh root@ droplet_ip
Connecting from Windows
Using terminal: ssh root@droplet_ip
4. Installing NGINX and Git
Update the System:
Sudo apt update
Sudo apt upgrade
Install NGINX:
Sudo apt install nginx
Install Git:
Sudo apt install git




5. Cloning the Website from GitHub
Navigate to the web directory = cd/var/www/html
Clone the github repo: 
Sudo git clone https: repo link

6. Buying and Configuring a Domain with Namecheap
Buy a Domain:
Go to Namecheap and purchase a domain.

Configure Domain DNS:
Go to your Namecheap account.
Navigate to the "Domain List" and click "Manage" next to your domain.
Go to the "Advanced DNS" tab and add an A Record pointing to your Droplet's IP address.
7. Pointing the Domain to the DigitalOcean Droplet
Set Nameservers in Namecheap:
In the Namecheap dashboard, under "Domain List" -> "Manage" -> "Nameservers," select "Custom DNS."
Add the DigitalOcean name servers:
ns1.digitalocean.com
ns2.digitalocean.com
ns3.digitalocean.com


Configure DNS in DigitalOcean:
Go to the DigitalOcean dashboard.
Navigate to "Networking" -> "Domains" and add your domain.
Create A Records pointing your domain and subdomains to your Droplet's IP address.


8. Configuring NGINX Root Location
Navigate to NGINX Configuration Directory: 
Cd /etc/nginx/sites-available
2. Create a New Configuration File:
Sudo nano /etc/nginx/sites-available/website1
Add the Following Configuration:
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    root /var/www/html/website1;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}

Enable the Configuration:
sudo ln -s /etc/nginx/sites-available/website1 /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

9. Deploy Script
Create the deploy.sh Script:
sudo nano /var/www/html/deploy.sh

Add the Following Script:
#!/bin/bash
# Change directory to the website directory
cd /var/www/html/website1
# Reset local changes in the repository
git reset --hard
# Pull latest changes from GitHub and force overwrite local changes
git pull origin main --force
# Restart Nginx to apply changes
systemctl restart nginx

Make the Script Executable:
sudo chmod +x /var/www/html/deploy.sh


10. Setting Up Cron Job for Automatic Deployment
Edit Crontab:
sudo crontab -e
Add the Following Cron Job:
* * * * * /var/www/html/deploy.sh
11. Test
Make some changes to the website and push it to github and wait one min to see if the website update automatically 

For reference this is my github account (https://github.com/badunrahman/website1)
