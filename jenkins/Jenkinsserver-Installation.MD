# Jenkins server Installation

### Prerequisites 
 1. EC2 Linux 7.x Instance

 2. Java v11.x

## Install Java
# We will be using open java for our demo, Get latest version from http://openjdk.java.net/install/
```sh
yum install java-11*
#yum -y install java-1.8.0-openjdk
```

### Confirm Java Version
# Lets install java and set the java home
```sh
java -version

# Chose the right version of JAVA --> Choose JAVA 11 
sudo update-alternatives --config java
sudo update-alternatives --config javac

# Find the JAVA version is using by CentOS  (Jenkins now is working with Java-11 or 17) 
find /usr/lib/jvm/java-11* | head -n 3
# The result is 
/usr/lib/jvm/java-11
/usr/lib/jvm/java-11-openjdk
/usr/lib/jvm/java-11-openjdk-11.0.17.0.8-2.el7_9.x86_64


# Open ROOT account and add the below command in the '.bash_profile'
#JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.16.1.1-1.el7_9.x86_64
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
# To set it permanently update your .bash_profile
source ~/.bash_profile
```
# _The output should be something like this,_
```
[root@localhost centos]# java --version
openjdk 11.0.16.1 2022-08-12 LTS
OpenJDK Runtime Environment (Red_Hat-11.0.16.1.1-1.el7_9) (build 11.0.16.1+1-LTS)
OpenJDK 64-Bit Server VM (Red_Hat-11.0.16.1.1-1.el7_9) (build 11.0.16.1+1-LTS, mixed mode, sharing)
```

## Install Jenkins
# You can install jenkins using the rpm or by setting up the repo. We will setup the repo so that we can update it easily in future.
# We will install the latest stable version of Jenkins  
# https://www.jenkins.io/doc/book/installing/linux/#red-hat-centos
Get latest version of jenkins from https://pkg.jenkins.io/redhat-stable/
```sh
yum -y install wget
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
```

# Centos often block port, so need to open the Jenkins port 8080 
firewall-cmd --zone=public --permanent --add-port=8080/tcp

# Reload firewall 

firewall-cmd --reload

------- Ubuntu

find /usr/lib/jvm/java-11* | head -n 3

# Open ROOT account and add the below command in the '.bash_profile'
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
# To set it permanently update your .bash_profile
source ~/.profile
```

sudo apt update
sudo apt install openjdk-11-jre
java -version

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
#----- end Ubuntu -------


### Start Jenkins
```sh
# Start jenkins service
systemctl start jenkins

# Setup Jenkins to start at boot,
systemctl enable jenkins
OR 
chkconfig jenkins on
```

### Check the port of server is using 
netstat -ntlp 

#### Accessing Jenkins
# By default jenkins runs at port `8080`, You can access jenkins at
```sh
http://YOUR-SERVER-PUBLIC-IP:8080
```
#### Configure Jenkins
- The default Username is `admin`
- Grab the default password 
  - Password Location:`/var/lib/jenkins/secrets/initialAdminPassword`
- `Skip` Plugin Installation; _We can do it later_
- Change admin password
  - `Admin` > `Configure` > `Password`
- Configure `java` path
  - `Manage Jenkins` > `Global Tool Configuration` > `JDK`  
- Create another admin user id

### Test Jenkins Jobs
1. Create new item
1. Enter an item name  `My-First-Project`
   - Chose `Freestyle` project
1. Under Build section
	Execute shell : echo "Welcome to Jenkins Demo"
1. Save your job 
1. Build job
1. Check "console output"


### To login to Jenkins by CLI
vi /etc/passwd
## -- Change the line 
jenkins:x:988:982:Jenkins Automation Server:/var/lib/jenkins:/bin/false
## become 
jenkins:x:988:982:Jenkins Automation Server:/var/lib/jenkins:/bin/bash


## Provide permissions to "jenkins" user in Jenkins server to access and use Docker
```sh
  sudo groupadd docker
  sudo usermod -aG docker jenkins
  sudo chmod 777 /var/run/docker.sock
```
## Add Jenkins user into sudoers file to get sudo access (Using application does not need to enter password)
```sh
   vi /etc/sudoers
   jenkins ALL=(ALL) NOPASSWD: ALL
```   


### ==== Difference between 'su jenkins' and 'su - jenkins'
### 'su jenkins' come to current folder 
azureuser@Jenkins-VM:~$ sudo su jenkins
jenkins@Jenkins-VM:/home/azureuser$ cd
jenkins@Jenkins-VM:~$ exit
exit

### 'su - jenkins' come to 'jenkins' user folder 
azureuser@Jenkins-VM:~$ sudo su - jenkins
jenkins@Jenkins-VM:~$ 


