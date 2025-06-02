#!/bin/bash
#!/data/data/com.termux/files/usr/bin/bash
# Essa linha de cima é chamada de shebang. Serve pra dizer qual interpretador usar pra rodar o script.
# https://pt.wikipedia.org/wiki/Shebang
#
#


# Só pra avisar se o script der erro e parar de rodar.
abort()
{
    echo >&2 '
***************
***   ERRO  ***
***************
'
    exit 1
}
trap 'abort' 0
set -e


########################################
# Prompts de configurações necessárias #
########################################

while true; do
  read -p "Deseja ativar o modo offline? Serve para jogadores entrarem sem estarem em uma conta. (s/n): " choice
  case "$choice" in
    [Ss]) 
      OFFLINE=true
      break
      ;;
    [Nn]) 
      OFFLINE=false
      break
      ;;
    *) 
      echo "Input inválido. Use S (para Sim) ou N (para Não)."
      ;;
  esac
done

while true; do
  read -p "Quantos GB de RAM deseja liberar para o servidor? Recomendado é 2. (Apenas números inteiros positivos) " choice
  if [[ "$choice" =~ ^[0-9]+$ ]]; then
    MAX_RAM_GB=$choice
    break
  else
    echo "Input inválido. Use somente números inteiros positivos."
  fi
done

echo "Máximo de ram utilizada: " $MAX_RAM_GB
echo "Modo offline: " $OFFLINE


################################
# Download e setup do servidor #
################################

echo "Baixando dependencias necessárias para o script..."
pkg update
pkg install wget openjdk-21

FOLDER_NAME="minecraft_server"
mkdir $FOLDER_NAME
echo "Criando pasta com configurações iniciais do servidor..."
echo "eula=true\n" >> $FOLDER_NAME/eula.txt


###################################
# Instalação do Playit (opcional) #
###################################
while true; do
  read -p "Deseja usar o playit-cli como túnel? (s/n): " choice
  case "$choice" in
    [Ss]) 
      echo "Baixando playit..."
      pkg install tur-repo
      pkg update 
      pkg install playit
      break
      ;;
    [Nn]) 
      echo "Ignorando playit e finalizando script..."
      break
      ;;
    *) 
      echo "Input inválido. Use S (para Sim) ou N (para Não)."
      ;;
  esac
done


echo '
*************
**** FIM **** 
*************
'
