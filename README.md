# Minecraft Server no Termux

Script para instalar e rodar um servidor Minecraft Java no Termux.

## Funcionalidades

* Instala o servidor oficial do Minecraft
* Permite escolher o modo online (autenticação da Mojang)
* Define o limite de RAM para o servidor
* Cria um script de inicialização
* Instala opcionalmente o playit para túnel de rede

## Pré-requisitos

* Termux instalado
* Conexão com a internet

## Como usar

Baixe o script:

```
curl -fSl https://raw.githubusercontent.com/joseiedo/termux_minecraft_server/main/setup.sh -o setup.sh
```

Execute:

```
bash setup.sh
```

Siga as instruções no terminal.

## Como iniciar o servidor

Após a instalação:

```
~/minecraft_server/init.sh
```

## Acesso externo (opcional)

Se instalou o playit, execute:

```
playit-cli
```

Use o endereço fornecido para que outros jogadores se conectem.

## Observações

* O script aceita automaticamente o EULA da Mojang (`eula=true`).
* O arquivo `server.properties` é configurado conforme suas escolhas durante a instalação.

## Deu problema ou quer fazer uma contribuição?

Abra uma [issue](https://github.com/joseiedo/termux_minecraft_server/issues) me marcando com `@joseiedo`! 
