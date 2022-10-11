#!/bin/sh

YELLOW='\033[1;33m'
GREEN='\033[32m'
NC='\033[0m'

#init
cd ~ && echo -e "${GREEN}Running script of setup${NC}"
echo

echo -e "${YELLOW}==========GIT==========${NC}"
sudo apt update
sudo apt install git
git --version
echo

echo -e "${YELLOW}Nome do usuário git:${NC}"
USERNAME=
read -r USERNAME

echo -e "${YELLOW}Endereço de email corporativo:${NC}"
EMAIL=
read -r EMAIL

git config --global user.name $USERNAME
git config --global user.email $EMAIL
echo 
git config --list
git config --global url."git@bitbucket.org:".insteadOf "https://bitbucket.org/"


##############
echo 
echo
##############


echo -e "${YELLOW}==========BITBUCKET==========${NC}"
echo -e "${YELLOW}Digite ENTER para todas as opções abaixo:${NC}"
ssh-keygen
ls ~/.ssh 
echo
cat ~/.ssh/id_rsa.pub > chave.txt 
echo 

# instalando aws cli
echo -e "${YELLOW}==========AWS CLI==========${NC}"
sudo apt install curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws/ awscliv2.zip

##############
echo 
echo
##############


echo -e "${YELLOW}==========NODE==========${NC}"
sudo apt update
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
echo

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completio

# #Verificando instalação do node e nvm
nvm install --lts
node -v
npm -v


##############
echo 
echo
##############


echo -e "${YELLOW}==========JAVA==========${NC}"

sudo apt install openjdk-11-jdk
java -version

echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin/java" >> $HOME/.bashrc
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin/java" >> $HOME/.zshrc

sudo update-alternatives --config java


##############
echo 
echo
##############


echo -e "${YELLOW}==========GOLANG==========${NC}"
sudo apt install golang-go
curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | zsh

sudo apt-get install bison

gvm version
gvm install go1.18 -B 
gvm install go1.17 -B 
gvm install go1.16 -B 
gvm use go1.18 --default
gvm list


#Criando estrutura de pastas
cd ~ && pwd
mkdir go && cd go && mkdir pkg bin src && cd src && mkdir bitbucket.org github.com && cd bitbucket.org && mkdir bemobidev


##############
echo 
echo
##############


echo -e "${YELLOW}==========DOCKER==========${NC}"
sudo apt update
sudo apt install docker.io
sudo apt install docker-compose
sudo systemctl start docker # Irá iniciar o Docker
sudo systemctl enable docker #Vai garantir que após a reinicialização vai continuar ligado
sudo usermod -aG docker $USER
newgrp docker

# Compose V2
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

#Verificando instalação do docker
docker -v
docker-compose --version
systemctl status docker
docker run hello-world

##############
echo
echo 
echo
echo
##############

#Verificando todas as instalações
echo "---------GIT---------"
git --version
echo "---------BITBUCKET KEYS---------"
ls ~/.ssh 
echo "---------AWS---------"
aws --version  
echo "---------DOCKER---------"
docker -v && docker-compose --version
echo "---------NODE---------"
node -v && npm -v
echo "---------JAVA---------"
java -version
echo "---------GOLANG---------"
go version && gvm list


##############
echo 
echo
##############


echo -e "${GREEN}===== SCRIPT FINALIZADO =====${NC}"