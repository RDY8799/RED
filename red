#!/bin/bash


path="/etc/rdy/modules/";
cred='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
blue='\033[1;34m'
none='\e[0m'
_cred() { echo -e ${cred}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

# Root
[[ $(id -u) != 0 ]] && echo -e "\n Ops, execute como usuário${cred}root ${none}! ${yellow}~(^_^) ${none}\n" && exit 1

cmd="apt-get"

# Verifica ano atual
year=$(date +'%Y')
ABOUT="© ${blue}Copyright ${yellow}RDY ${cred}SOFTWARE ${yellow}{${cred}}${none} ${blue}${year}${none}";

cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/	//' > /etc/so

# VERIFICAR O IP DO SERVIDOR
INTERNAL_IP=(hostname -I)
PUBLIC_IP=$(wget -qO- icanhazip.com)
#ippublic="${white}IP público:${cyan} ${none}indippublic${none}";
SYSTEM_NAME=(cat /etc/so)

VERSION="v1.0.1";
USERNAME="USUÁRIO";
SYSTEM="SISTEMA";
USERPROFILENAME=$USER;

###### CONF. RAM/MEMÓRIA
CPU_USADA="CPU USADA:";
RAM_USADA="RAM USADA:";
MB="MB";
LIVRE="LIVRE:";
SWAP="SWAP";
###### FIM

FIREWALL="FIREWALL";
UPDATE_SYSTEM="ATUALIZAR SISTEMA";
SPEEDTEST="TESTAR VELOCIDADE DE BANDA-${magneta}SPEEDTEST$f";
REBOOT_SYSTEM="REINIICIAR SISTEMA";
NOTIFICATION="Notificações";
MENU_INSTALL="INSTALADOR/COFIGURAR";
MANAGE_USERS="GERENCIAMENTO DE USUÁRIOS";
TOOLS="FERRAMENTAS";
EXIT="SAIR";
OP_NOT_DEVELOPED="OPÇÃO NÃO DESENVOLVIDA";
OK="✓ OK ✓";

# ESTADO DE RAM
CPU=$(ps aux  | awk 'BEGIN { sum = 0 }  { sum += sprintf("%f",$3) }; END { printf " " "%.2f" "%%", sum}')
totalram=$(free | grep Mem | awk '{print $2}')
usedram=$(free | grep Mem | awk '{print $3}')
freeram=$(free | grep Mem | awk '{print $4}')
swapram=$( cat /proc/meminfo | grep SwapTotal | awk '{print $2}')

DIVIS="${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}${blue}/${none}${white}==${none}";

HEADER="$yellow CPU USADA:$cyan$CPU ${blue}|${none}$yellow RAM USADA: $cyan$(($usedram / 1024))MB$yellow LIVRE: $cyan$(($freeram / 1024))MB ${blue}|${none}$yellow SWAP: $cyan$(($swapram / 1024))MB ${none}\n$green ##### $white IP:$cyano  $PUBLIC_IP | Interno: $INTERNAL_IP ${none}\n$green ##### $white $SYSTEM:$cyan  $SYSTEM_INFO ${none}\n$green ##### $white $USER:$cyan  $USERPROFILENAME ${none}\n$DIVIS\n$green $yellow [${blue}i$yellow] $yellow=${none}$white $NOTIFICATION $yellow 0        ${blue}/${cred}/${green}/ $cyan$ABOUT${none}\n$DIVIS";

# PROGRESS BAR
RDYSPINNER()
{
    local pid=$!
    local delay=0.50
    local spinstr='|/-\'
	tput civis -- invisible
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " ${yellow}[${magenta}%c${cred}]${none}  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
	tput cnorm -- normal
}


# TIPO DE SISTEMA
if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/credhat-release ]]; then
	OS=centos
	GROUPNAME=nobody
	RCLOCAL='/etc/rc.d/rc.local'
else
	echo "Looks like you aren't running this installer on a Debian, Ubuntu or CentOS system"
	exit 2
fi

error() {

	echo -e "\n$cred ERRO！PARA MAIS INFORMAÇÕES, ACESSE NOSSO CANAL NO TELEGRAM @rdysoftware$none\n"

}

INSTALL_PKG(){
REQUIcred_PKG=$1
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIcred_PKG|grep "install ok installed")
if [ "" = "$PKG_OK" ]; then
  echo -e "${cred} Necessário $REQUIcred_PKG. ${yellow} Instalando $REQUIcred_PKG..."
  sudo $cmd --yes install $REQUIcred_PKG 1> /dev/null 2>/dev/null
echo -e "${green} $OK ${none}";
fi

}

NETSTAT(){
INSTALL_PKG net-tools
netstat -nlpt
echo -ne "${white}//${yellow}//${green}//${mag}//    ${green}Pressione uma tecla para retornar ao menu inicial...$f"; read -n1 -r -p "";
}

install(){
echo
echo -e "${yellow} CRIANDO PASTAS EM /etc/rdy...$none";
if [ ! -d /etc/rdy/strings/ ]
then
echo -e "${yellow} Criando diretório de strings...$none";
sleep 1
mkdir -p /etc/rdy/strings
touch /etc/rdy/instaled
echo true > /etc/rdy/instaled
echo -e "${yellow} Baixando arquivo de strings...$none";
wget -P ${path}strings https://raw.githubusercontent.com/RDY8799/cred/master/STRINGS 1> /dev/null 2> /dev/null
chmod 711 ${path}strings/strings 1> /dev/null 2> /dev/null
sleep 1
fi

echo

echo -e "${yellow} Baixando módulos...$none";
folders=("usermanager" "tools" "install")
for str in $folders[@]}; do
  if [ ! -d ${path}$str ]
then
mkdir -p ${path}$str
fi
if test -f "${path}$str"; then
   rm ${path}$str
fi
wget -P ${path}$str https://raw.githubusercontent.com/RDY8799/cred/master/$str 1> /dev/null 2> /dev/null
chmod 711 ${path}$str/$str 1> /dev/null 2> /dev/null
done

echo -e "${green} $OK ${none}";
}

RDYABOUT(){
INSTALL_PKG figlet
echo -e $DIVIS
figlet 'RDY SOFTWARE' -f small
echo -e "\n\n";
echo -e "${yellow}   //// ${cred}// ${green}/  ${yellow}RDY SCRIPT - cred\n${yellow}   //// ${cred}// ${green}/  V 1.0.0\n\n${green} Telegram Canal: ${cred}@rdysoftware\n${green} Telegram contato: ${cred}@tomada$f";
echo -e "\n\n";
echo -e $DIVIS
echo -ne "${white}//${yellow}//${green}//${mag}//    ${green}Pressione uma tecla para retornar ao menu inicial...$f"; read -n1 -r -p "";
red menu
}

menu(){
clear
echo 
echo -e "${DIVIS}"; 
echo -e "${HEADER}";
echo -e "$green $yellow [${blue}01$yellow] $yellow=$f$white $MENU_INSTALL $f"; 
echo -e "$green $yellow [${blue}02$yellow] $yellow=$f$white $MANAGE_USERS $f"; 
echo -e "$green $yellow [${blue}03$yellow] $yellow=$f$white $TOOLS $f"; 
echo -e "$green $yellow [${blue}04$yellow] $yellow=$f$white SOBRE $f";
echo -e "$green $yellow [${blue}00$yellow] $yellow=$f$white $EXIT $f";
echo -e $DIVIS
echo -ne "$yellow Opção:$f";read -p ""  option
case $option in

i | I ) echo -e "${white}//${yellow}//${green}//${mag}//    ${green}$OP_NOT_DEVELOPED$f";
red menu;;
n | net | N | NET) 
red menu;;
1 | 01) bash ${path}install/install;;
2 | 02) bash ${path}usermanager/usermanager;;
3 | 03) bash ${path}tools/tools;;
4 | 04) RDYABOUT;;
un ) rm ${path}installed ;;
00 | 0) exit ;;
remove_all | r_all ) 
echo -e "removendo resíduos, isso é ${cred}PERIGOSO!$f";
find /tmp -mtime +7 |\
    egrep -v "`lsof -n +D /tmp | awk 'NR>1 {print $9}'| tr \\n \|`" & RDYSPINNER
		echo "concluído!";;
 *)echo -e "$cred Opção inválida $none" ; echo "" ; sleep 2 ; 
red menu
;;
   esac
#######################################################################################
}

load(){
if [ $(cat /etc/rdy/instaled) == "true" ]; then
menu
else

echo -e "${ABOUT}";
echo
echo -e "${yellow} > RED SCRIPT < $none";
echo 

while :; do
		echo -e "${yellow}Continuar com a instalação do script?${none} [${magenta}Y/N$none]"
		read -p "$(echo -e "([${cyan}N$none]):") " option
		[[ -z "$option" ]] && option="n"
		if [[ "$option" == [YySs] ]]; then
			echo
			install
			break
		elif [[ "$option" == [Nn] ]]; then
			break
		else
			error
		fi

	done

fi

}

if [[ $1 == "un" ]]; then
        rm ${path}installed
        exit 1
fi

if [[ $1 == "menu" ]]; then
        menu
        exit 1
fi

if [[ $1 == "net" ]]; then
        NETSTAT
        exit 1
fi


if [[ $1 == "usermanager" ]]; then
        bash ${path}usermanager/usermanager
        exit 1
fi


load

