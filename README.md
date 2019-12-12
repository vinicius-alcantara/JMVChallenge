# JMVChallenge

## 1) - Crie um script para a realização de backup, este script deverá realizar o backup diário do banco e de alguns arquivos de configurações, videos, entre outros. Deve-se seguir os passos a seguir:
* Crie a o diretório "/backup/backup_banco/", caso a pasta já estiver sido criada pode ocorrer um erro e o script pode parar nesse ponto, lembre-se de tratar, para que não haja esse erro.
* Faça o dump dos bancos MySQL e MongoDB e armazene no diretório criado anteriormente.
* Compacte os diretórios "/backup/backup_banco/" e "/home/" em um arquivo .tar.gz, salve-o no diretório "/backup/", lembre-se de salvá-lo com a data para que possibilite o controle e remoção de backups antigos.
* Mova o arquivo para outro servidor, salve-o no diretório "/backup/servidor_teste/" do servidor remoto, remova o arquivo .tar.gz do servidor de origem, para esse passo ultilize a aplicação rsync.
* obs: Todos esses passos devem estar no script, nada deve ser realizado manualmente no terminal, ou seja, este script deve rodar em qualquer servidor, sem que para isso seja necessário criar uma estrutura de pastas pré-definidas antes de executá-lo.

## 2) - Este script deve ser executado todos os dias ás 3:00 da manhã, qual aplicação nativa do sistema operacional deve ser utilizada para tal e como ficará a inserção deste agendamento no arquivo padrão da aplicação?

## 3)Utilize docker como servidores virtuais para trabalhar com os arquivos remotos, no caso containers.

## 4) - Criar um POP (Procedimento Operacional Padrão) para que esse script possa ser adicionado em um novo servidor.
