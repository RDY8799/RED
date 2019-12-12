#!/bin/bash

change_password(){

read -p "USER: " user

if cat /etc/passwd |grep $user: > /dev/null
then
read -p "SENHA: " password
(echo $password; echo $password)|passwd $user 2>/dev/null
echo "$password" > /etc/rdy/senha/$user
echo -e "RDYOK";
else
echo -e "RDYNOEXISTS";
fi
}


remove_user_limit(){

read -p "USER: " user

 if cat /etc/passwd |grep $user: > /dev/null
then
cronsemuser=$(cat /etc/crontab |grep -v "#$user#")
echo "$cronsemuser" > /etc/crontab
rm -rf /etc/rdy/limite/$user 2>/dev/null
rm -rf /etc/rdy/limite/$user.sh 2>/dev/null
pids=$(ps x |grep "#$user#" |awk {'print $1'})
kill $pids 2>/dev/null
kill "$pids" 2>/dev/null
kill -9 `ps x |grep "#$user#" |awk {'print $1'}` 2>/dev/null
kill `ps x |grep "#$user#" |awk {'print $1'}` 2>/dev/null
echo -e "RDYOK";
 else
echo -e "RDYNOEXISTS";
 fi
}


disconect_user(){
read -p "USER: " user

if cat /etc/passwd |grep $user: > /dev/null
then
pkill -9 -u $user
echo "RDYOK";
else
echo -e "RDYNOEXISTS";
 fi
}


create_user_time(){

if [ ! -d /etc/rdy/rdy_test_users ]
then
mkdir -p /etc/rdy/rdy_test_users
fi

for testus in $(ls /etc/rdy/rdy_test_users |sort |sed 's/.sh//g')
do
echo "$testus"
done
printf "\n"
read -p "USUARIO" user

read -p "SENHA: " pass

read -p "TEMPO(Use s = segundos, m = minutos, h = horas e d = dias): " tempoin

tempo=$(echo "$tempoin" |sed 's/ //g')
useradd -M -s /bin/false $user
(echo $pass;echo $pass) |passwd $user 1>/dev/null 2>/dev/null
echo "#!/bin/bash
sleep $tempo
kill"' $(ps -u '"$user |awk '{print"' $1'"}') 1>/dev/null 2>/dev/null
userdel --force $user
rm -rf /etc/rdy/rdy_test_users/$user.sh
exit" > /etc/rdy/rdy_test_users/$user.sh

bash /etc/rdy/rdy_test_users/$user.sh &

echo "RDYOK";

exit

}

##  APAGAR USUÁRIO

delete_user(){
read -p "User: " user
if cat /etc/passwd |grep $user: > /dev/null
then
userdel --force $user > /dev/null 2>/dev/null
echo -e "RDYOK";
else
echo -e "RDYNOEXISTS";
fi

}

create_user(){

read -p "" user
if cat /etc/passwd |grep $user: |grep -vi [a-z]$user |grep -v [0-9]$user > /dev/null
	then
echo -e "RDYEXISTS"

else
read -p "" password
read -p "" days
read -p "" logins

rdyw=$(date '+%C%y-%m-%d' -d " +$days days")
rdyx=$(date "+%d/%m/%Y" -d "+ $days days")
useradd -M -s /bin/false $user -e $rdyw
		(echo $password; echo $password)|passwd $user 2>/dev/null
#limit $user $logins




############  DEFININDO LIMITE


SIFRAO=$

echo "#!/bin/bash" > /etc/rdy/usuarios/$user.sh

echo ""$user"t="$SIFRAO"(ps -u $user |grep 'sshd' |wc -l)" >> /etc/rdy/usuarios/$user.sh

echo "if [ "$SIFRAO""$user"t -gt $2 ]" >> /etc/rdy/usuarios/$user.sh

echo "then" >> /etc/rdy/usuarios/$user.sh

echo $user"pidi="$SIFRAO"(ps -u $user |grep sshd |awk {'print "$SIFRAO"1'})" >> /etc/rdy/usuarios/$user.sh

echo 'echo "'$SIFRAO''$user''pidi'" > /etc/rdy/usuarios/pid'$user >> /etc/rdy/usuarios/$user.sh

echo $user"pid="$SIFRAO"(cat -n /etc/rdy/usuarios/pid$user |awk ' "$SIFRAO"1 > $2 { print "$SIFRAO"NF }')" >> /etc/rdy/usuarios/$user.sh

echo "kill -9 $SIFRAO"$user"pid" >> /etc/rdy/usuarios/$user.sh

echo "fi" >> /etc/rdy/usuarios/$user.sh

mkdir /etc/rdy/tempo 1>/dev/null 2>/dev/null

echo "#!/bin/bash" > /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh

echo "$logins" > /etc/rdy/limite/$user

echo "*/1 * * * * root bash /etc/rdy/tempo/$user.sh" >> /etc/crontab
echo "#" >> /etc/crontab

echo "$password" > /etc/rdy/senha/$user
echo "$rdyw" > /etc/rdy/rdy_date/$user

echo "RDYOK";
exit
fi
}

change_user_limit(){
read -p "USER: " user
if cat /etc/passwd |grep $user: > /dev/null
then
usercon=$(ps -u $user | grep sshd | wc -l)
read -p "LIMITE: " logins
############  DEFININDO LIMITE


SIFRAO=$

echo "#!/bin/bash" > /etc/rdy/usuarios/$user.sh

echo ""$user"t="$SIFRAO"(ps -u $user |grep 'sshd' |wc -l)" >> /etc/rdy/usuarios/$user.sh

echo "if [ "$SIFRAO""$user"t -gt $2 ]" >> /etc/rdy/usuarios/$user.sh

echo "then" >> /etc/rdy/usuarios/$user.sh

echo $user"pidi="$SIFRAO"(ps -u $user |grep sshd |awk {'print "$SIFRAO"1'})" >> /etc/rdy/usuarios/$user.sh

echo 'echo "'$SIFRAO''$user''pidi'" > /etc/rdy/usuarios/pid'$user >> /etc/rdy/usuarios/$user.sh

echo $user"pid="$SIFRAO"(cat -n /etc/rdy/usuarios/pid$user |awk ' "$SIFRAO"1 > $2 { print "$SIFRAO"NF }')" >> /etc/rdy/usuarios/$user.sh

echo "kill -9 $SIFRAO"$user"pid" >> /etc/rdy/usuarios/$user.sh

echo "fi" >> /etc/rdy/usuarios/$user.sh

mkdir /etc/rdy/tempo 1>/dev/null 2>/dev/null

echo "#!/bin/bash" > /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh
echo "sleep 5s" >> /etc/rdy/tempo/$user.sh
echo "bash /etc/rdy/usuarios/"$user".sh" >> /etc/rdy/tempo/$user.sh

echo "$logins" > /etc/rdy/limite/$user

echo "*/1 * * * * root bash /etc/rdy/tempo/$user.sh" >> /etc/crontab
echo "#" >> /etc/crontab

echo "RDYOK";
else
echo "RDYNOEXISTS";
fi
}

change_user_date(){
read -p "USER: " user
if cat /etc/passwd |grep $user: > /dev/null
then
read -p "DATE: " dia
chage -E $dia $user 2> /dev/null
echo "RDYOK";
 else
echo "RDYNOEXISTS";
 fi
}



if [[ $1 == "create_user" ]]; then
        create_user
        exit 1
fi

if [[ $1 == "delete_user" ]]; then
        delete_user
        exit 1
fi

if [[ $1 == "create_user_time" ]]; then
        create_user_time
        exit 1
fi

if [[ $1 == "change_user_limit" ]]; then
        change_user_limit
        exit 1
fi

if [[ $1 == "change_user_date" ]]; then
        change_user_date
        exit 1
fi

if [[ $1 == "change_passwod" ]]; then
        change_passwod
        exit 1
fi

if [[ $1 == "remove_user_limit" ]]; then
        remove_user_limit
        exit 1
fi

if [[ $1 == "info_user" ]]; then
        info_user
        exit 1
fi

if [[ $1 == "command" ]]; then
        info_user
        exit 1
fi



