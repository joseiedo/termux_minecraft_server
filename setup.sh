#!/data/data/com.termux/files/usr/bin/bash
# Essa linha de cima é chamada de shebang. Serve pra dizer qual interpretador usar pra rodar o script.
# https://pt.wikipedia.org/wiki/Shebang

set -e # Se falhar algo, o script para.

########################################
# Prompts de configurações necessárias #
########################################
while true; do
  read -p "Deseja ativar o modo online? Isso bloqueia jogadores sem entrarem no seu servidor. (s/n): " choice
  case "$choice" in
    [Ss])
      ONLINE=true
      break
      ;;
    [Nn])
      ONLINE=false
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
echo "Modo online: " $ONLINE

################################
# Download e setup do servidor #
################################

echo "Baixando dependencias necessárias para o script..."
pkg update
pkg install wget openjdk-21

FOLDER_NAME="minecraft_server"
echo "Criando pasta $FOLDER_NAME..."
mkdir -p $FOLDER_NAME
cd $FOLDER_NAME

echo "Baixando configurações servidor..."
curl -f https://raw.githubusercontent.com/joseiedo/termux_minecraft_server/refs/heads/main/server.base.properties -o server.properties
echo "eula=true" >> eula.txt
echo "online-mode=$ONLINE" >> server.properties

# Link retirado daqui -> https://www.minecraft.net/pt-br/download/server
echo "Baixando .jar do minecraft..."
wget https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -O ~/$FOLDER_NAME/server.jar

INIT_SCRIPT="java -Xms1G -Xmx${MAX_RAM_GB}G -jar server.jar nogui"
INIT_SCRIPT_LOCATION=init.sh

echo "
#!/data/data/com.termux/files/usr/bin/bash
$INIT_SCRIPT
" >> $INIT_SCRIPT_LOCATION

chmod +x $INIT_SCRIPT_LOCATION

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

echo "Servidor baixado!"
echo "Para iniciar o servidor, rode: cd $FOLDER_NAME && ./$INIT_SCRIPT_LOCATION"
