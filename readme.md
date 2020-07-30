Subindo aplicação de chat em tempo real em Nodejs utilizando Express, Mongodb, socket.io, Docker e em um Pipeline com Jenkins utilizando Ubuntu 18.04

Para iniciarmos, vamos instalar as aplicações necessárias:

Instale o Nodejs com o seguinte comando;
'curl -sL https://deb.nodesource.com/setup_12x.x | sudo -E bash -'
'sudo apt-get install -y nodejs'

Instale o Docker com os seguintes comandos; 

Atualize as releases do SO
'apt-get update -y'

Instale os pacotes necessários para instalação do repositório
'sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

Adicionando a chave oficial docker
'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'

Agora adicionando o repositório atual (30/07/2020)
'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'

Atualize novamente os pacotes para garantir que está na última versão
'sudo apt-get update -y'

Agora finalmente a instalaçao do docker
'sudo apt-get install docker-ce docker-ce-cli containerd.io -y'

