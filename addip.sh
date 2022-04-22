#!/bin/bash
echo "Input IP"
read -e -p "(Default: ):" user
CLIENT_EXISTS=$(grep -w $user /home/listip | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo ""
echo "vps sudah terdaftar."
exit 1
fi
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$user" >> /home/vps/public_html/BskaoahdmsoahamoaJNlapabsmal
echo -e "### $user $exp" >> /home/listip
clear
echo "Done"
echo "Your IP Has Been Registered"
echo -e "==============================="
echo "IP         : $user"
echo "Expired ON : $exp"
echo -e "==============================="
