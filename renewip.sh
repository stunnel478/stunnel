#!/bin/bash
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/home/listip")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^### " "/home/listip" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/home/listip" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/home/listip" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
tgl=$(echo "$exp4" | cut -d- -f3)
bln=$(echo "$exp4" | cut -d- -f2)
sed -i "s/### $user $exp/### $user $exp4/g" /home/listip
clear
echo ""
echo " Your IP Has Been Successfully Renewed"
echo " =========================="
echo " Your IP : $user"
echo " Expired On  : $exp4"
echo " =========================="

