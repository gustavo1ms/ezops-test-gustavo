<<<<<<< HEAD
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

=======
## Manual de configuração de Pipeline de implementação de aplicação de chat em NodeJS usando Express, Mongodb e Socket.io no Ubuntu 18.04 <h3>
- Com o docker instalado no servidor - Caso não tenha o Docker instalado, siga [esta documentação](https://docs.docker.com/engine/install/ubuntu/) para realizar a instalação 

Suba o servidor MongoDB utilizando o mlab <https://mlab.com/>

Faça a instalação do git em sua máquina: 
```
sudo apt-get install git-all
```

Faça o clone do repositório onde está o código fonte, que você pode alterar livremente se preferir: 
```
git clone https://github.com/gustavo1ms/ezops-test-gustavo
```

Lembre-se de acessar os arquivos server.js e index.html e alterar de acordo com as configurações de seu ambiente.

O Dockerfile irá ser baixado juntamente dos demais arquivos pelo git: 
~~~Dockerfile 
FROM node:12

WORKDIR /ezopsapp

COPY package*.json ./

RUN npm install --silent

COPY . .

EXPOSE 3000

ENTRYPOINT node ./server.js
~~~

Com o jenkins instalado siga os passos abaixo. Caso não tenha o jenkins instalado, siga a [documentação oficial](https://www.jenkins.io/doc/book/installing/#debianubuntu)

- Vá em **Novo Job**
- Digite um nome para seu pipeline, selecione **Pipeline** e clique em **OK**
- Clique em **CONFIGURAR**, dê uma descrição e marque **GITHUB PROJECT** para que seu repositório fique documentado
- Selecione **Consultar periodicamente o SCM** e faça o agendamento conforme desejar - Caso não saiba como agendar [consulte a documentação](https://www.jenkins.io/doc/book/pipeline/syntax/#cron-syntax)
- Na seção **Pipeline** insira o script abaixo:
~~~node
node {
    def mnvHome
    stage('adicionando repo') {
        git 'https://github.com/gustavo1ms/ezops-test-gustavo.git'
    }

    stage('fazendo build') {
        sh label: '', script: 'sudo docker build -t nodeapp .'
    }

    stage('Parando serviços') {
        sh label: '', script: 'sudo docker stop $(sudo docker ps -a -q); sudo docker container prune -f'
    }

    stage('contruindo container') {
        sh label: '', script: 'sudo docker run --name nodeapp -p 3000:3000 -d nodeapp'
    }
}    
~~~
- Clique em **Salvar**

Caso tenha alterado os arquivos index.html e server.js realizando os apontamentos corretos, ao clicar em **CONSTRUIR AGORA** seu Pipeline terá êxito. 

Se apresentar erros, você pode checar os logs pelo Jenkins acessando o **Console Output**
>>>>>>> eb88d5f3a182814ea07324d92ecc6c791edbccec
