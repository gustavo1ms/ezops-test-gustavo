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