# blog.johanv.xyz

This is [my blog](https://blog.johanv.xyz/) that uses WriteFreely deployed to Dokku.

Here's a blog post describing how I set up my entire website with dokku: [How I Created johanv.xyz](https://blog.johanv.xyz/how-i-created-johanv-xyz). I have duplicated the instructions for just the blog subdomain here, and this version will be the one I keep updated. Note: this guide uses johanv.xyz as the domain name, so when following the instructions, just substitute your domain name wherever you see it. Also, [let me know](https://johanv.xyz/contact/) if you find a mistake in this documentation.

# Installation

## Getting a Dokku Server Running

### Rent a cloud server
I'm using a [DigitalOcean](https://www.digitalocean.com/) droplet for $5 a month, choosing the operating system image with dokku pre-installed. However, you can just as easily get a Debian based cloud server from any provider and install it yourself. And you can always self-host by [installing Debian](https://www.howtoforge.com/tutorial/debian-minimal-server/) on an old computer, connecting it to your router, and port forwarding ports 22, 80, and 443 from the router to the computer. There are pros and cons to each approach, which is beyond the scope of this README -- you can find plenty of info [online](https://duckduckgo.com/?q=cloud+vs+self+host).

### Rent a Domain Name
I got johanv.xyz on [NameSilo](https://www.namesilo.com/) for only a few dollars a year. Then point the domain name to the IP address of your cloud server with a DNS A record. If you are using DigitalOcean, or another provider that can manage DNS records, you can do what I did: point the nameservers of your domain registrar (NameSilo for me) to your cloud provider (DigitalOcean for me). Then the DNS records are managed by DigitalOcean and you can set up the A record there to point to your cloud server.

### Install Dokku
Based on [this guide](https://upcloud.com/community/tutorials/get-started-dokku-debian/).

Update and install Docker, Dokku, and dependencies.
```
ssh root@123.45.67.89 #replace this with your server's ip address
apt update
apt dist-upgrade

# Install the prerequisites
apt install -qq -y apt-transport-https

# Install Docker
wget -nv -O - https://get.docker.com/ | sh

# Add Dokku apt repository
wget -nv -O - https://packagecloud.io/gpg.key | sudo apt-key add -
export SOURCE="https://packagecloud.io/dokku/dokku/ubuntu/"
echo "deb $SOURCE trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
apt update -qq

# Install Dokku, when asked, select YES to enable web setup
apt-get install -qq -y dokku
dokku plugin:install-dependencies --core

#OLD: apt install -qq -y dokku herokuish sshcommand plugn

reboot
```

**Complete the following step as soon as possible, or someone else will eventually! :)**

Create an ssh key:
```
ssh-keygen -b 4096
cat ~/.ssh/id_rsa.pub
```

To execute dokku commands on the server, you will have to first run `ssh-add ~/.ssh/id_rsa` locally. You'll have to run this command every time you reboot your local computer.

Go to your domain name in a browser, and you will see a dokku setup page. Copy and paste in the SSH public key (NOT private key) from before. Enter your domain name, and check the box labelled "use virtualhost naming for apps."

## Installing the Blog
I followed [this tutorial by Evan Walsh](https://write.hellowelcome.org/evan/deploying-writefreely-via-dokku).

### Clone the Repo
```
git clone https://gitlab.com/johanvandegriff/blog.johanv.xyz.git
```
You will want to edit config.ini and change the site's name and URL. I set it to a single-user instance, so you may want to change it back to a multi-user setup.

I also used a bash script to patch the docker image, adding a footer with my email address, among other things. You will want to change the email address to your own, or remove it (I don't want to get random emails because you left it as mine. :) The address is obfuscated, so it's kind of awkward to change, but I have published the [PHP code I used to generate it](https://gitlab.com/johanvandegriff/johanv.xyz/blob/master/header.php#L92). There are tons of other [ways ot obfuscate email addresses](https://stackoverflow.com/questions/748780/best-way-to-obfuscate-an-e-mail-address-on-a-website) as well.

### Deploy to Dokku
```
ssh dokku@johanv.xyz apps:create blog

# Set up persistent storage to preserve the database and keys when rebuilding the app:
ssh root@johanv.xyz mkdir -p /var/lib/dokku/data/storage/writefreely/{db,keys}
ssh root@johanv.xyz chown -R bin:bin /var/lib/dokku/data/storage/writefreely/
#https://github.com/dokku/dokku/issues/2215

ssh dokku@johanv.xyz storage:mount blog /var/lib/dokku/data/storage/writefreely/keys:/go/keys
ssh dokku@johanv.xyz storage:mount blog /var/lib/dokku/data/storage/writefreely/db:/go/db
ssh dokku@johanv.xyz proxy:ports-set blog http:80:8080

# Push the app to Dokku:
git remote add dokku dokku@johanv.xyz:blog
git push dokku master #this build fails

#Now, the site is visible, but it displays an internal error. Initialize the instance:
ssh dokku@johanv.xyz run blog --help
ssh dokku@johanv.xyz run blog --init-db
ssh dokku@johanv.xyz run blog --gen-keys

# And rebuild the app:
ssh dokku@johanv.xyz ps:rebuild blog

# Set up the blog admin password. Put a real password instead of just "password"
ssh dokku@johanv.xyz run blog -create-admin johanv:password
```

## HTTPS with Let's Encrypt
Enable HTTPS, or your admin password for the blog will be sent in plaintext and would be very easy to steal!

Fortunately, Dokku has a nice plugin that makes this easy:
```
ssh root@johanv.xyz dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
ssh dokku@johanv.xyz letsencrypt:cron-job --add #auto renew certs
```

Add HTTPS to the blog (replace my@email.address with your actual email):
```
ssh dokku@johanv.xyz config:set --no-restart blog DOKKU_LETSENCRYPT_EMAIL=my@email.address
ssh dokku@johanv.xyz letsencrypt blog
```

## Credits

* [Comprehensive Dokku Tutorial by Max Schmidt](https://maximilianschmitt.me/posts/tutorial-deploy-apps-websites-dokku/)
* [Let's Encrypt Cert for Main Domain](https://github.com/dokku/dokku-letsencrypt/issues/146)
* [WriteFreely for Dokku by Evan Walsh](https://write.hellowelcome.org/evan/deploying-writefreely-via-dokku)
* [Permissions Issue in WriteFreely](https://github.com/dokku/dokku/issues/2215)
* [Adding a New SSH Key](https://www.digitalocean.com/community/questions/dokku-add-new-ssh-key)
* [How to Get Started with Dokku Debian by Janne Ruostemaa](https://upcloud.com/community/tutorials/get-started-dokku-debian/)