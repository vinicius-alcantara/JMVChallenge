# Procedimento Operacional Padrão

## Dependencias no Servidor de Banco de Dados (Pacotes):

* install mail-utils
* install unzip
* install rsync (Se for o caso - A maioria das distribuições já vem por padrão)
* Importar a chave pública ssh para o servidor remoto
* Definir o agendamento da execução do script na cron

### Exemplo de agendamento (/etc/crontab ou crontab -e para modificar o arquivo): 
m h  dom mon dow   command
00 03 * * * /bin/bash -c  /home/vinicius/JMVChallenge/backup_JMV.sh

## Dependencias no Servidor Docker Host

* docker
* Buildar as Imagens Base a partir dos Dockerfiles disponibilizados

## Dependencias no Servidor de Backup Remoto:

* Criar o usuário de backup
* Instalar o rsync (Se for o caso - A maioria das distribuições já vem por padrão)
* Criar o diretório de backup

## Ajuste no Scrip backup_JMV.sh

* Informar os valores corretos para as variáveis de acesso aos bancos de dados
* Informar o valor (Endereço IP) correto na variável do servidor remoto 
