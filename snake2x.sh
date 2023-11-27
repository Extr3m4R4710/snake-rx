#!/bin/bash
#FontColor_Red="\033[31m"
FontColor_Red_Bold="\033[1;31m"
#FontColor_Blue="\033[1;34m"
#FontColor_Blue_Bold="\033[1;34m"
#FontColor_Green="\033[32m"
#FontColor_Green_Bold="\033[1;32m"
FontColor_Okegreen='\033[1;92m'
#FontColor_Yellow="\033[33m"
FontColor_Yellow_Bold="\033[1;33m"
#FontColor_Purple="\033[35m"
#FontColor_Purple_Bold="\033[1;35m"
NC="\e[00m"

version="0.1.3"								## Version
example_domain="one.one.one.one" 			## Example domain
sleeptime=6									## Delay between queries, in seconds
domain=$1 									## Get the domain
browser='NAK'								## Browser information for curl
site="site:$domain" 						## searX Site

## Login pages
lpadmin="inurl:admin"
lplogin="inurl:login"
lpadminlogin="inurl:adminlogin"
lpcplogin="inurl:cplogin"
lpweblogin="inurl:weblogin"
lpquicklogin="inurl:quicklogin"
lpwp1="inurl:wp-admin"
lpwp2="inurl:wp-login"
lpportal="inurl:portal"
lpuserportal="inurl:userportal"
lploginpanel="inurl:loginpanel"
lpmemberlogin="inurl:memberlogin"
lpremote="inurl:remote"
lpdashboard="inurl:dashboard"
lpauth="inurl:auth"
lpexc="inurl:exchange"
lpfp="inurl:ForgotPassword"
lptest="inurl:test"
loginpagearray=("$lpadmin" "$lplogin" "$lpadminlogin" "$lpcplogin" "$lpweblogin" "$lpquicklogin" "$lpwp1" "$lpwp2" "$lpportal" "$lpuserportal" "$lploginpanel" "$lpmemberlogin" "$lpremote" "$lpdashboard" "$lpauth" "$lpexc" "$lpfp" "$lptest")

## Filetypes
ftdoc="filetype:doc"						## Filetype DOC (MsWord 97-2003)
ftdocx="filetype:docx"						## Filetype DOCX (MsWord 2007+)
ftxls="filetype:xls"						## Filetype XLS (MsExcel 97-2003)
ftxlsx="filetype:xlsx"						## Filetype XLSX (MsExcel 2007+)
ftppt="filetype:ppt"						## Filetype PPT (MsPowerPoint 97-2003)
ftpptx="filetype:pptx"						## Filetype PPTX (MsPowerPoint 2007+)
ftmdb="filetype:mdb"						## Filetype MDB (Ms Access)
ftpdf="filetype:pdf"						## Filetype PDF
ftsql="filetype:sql"						## Filetype SQL
fttxt="filetype:txt"						## Filetype TXT
ftrtf="filetype:rtf"						## Filetype RTF
ftcsv="filetype:csv"						## Filetype CSV
ftxml="filetype:xml"						## Filetype XML
ftconf="filetype:conf"						## Filetype CONF
ftdat="filetype:dat"						## Filetype DAT
ftini="filetype:ini"						## Filetype INI
ftlog="filetype:log"						## Filetype LOG
ftidrsa="index%20of:id_rsa%20id_rsa.pub"	## File ID_RSA
filetypesarray=("$ftdoc" "$ftdocx" "$ftxls" "$ftxlsx" "$ftppt" "$ftpptx" "$ftmdb" "$ftpdf" "$ftsql" "$fttxt" "$ftrtf" "$ftcsv" "$ftxml" "$ftconf" "$ftdat" "$ftini" "$ftlog" "$ftidrsa")

## Directory traversal
dtparent='intitle:%22index%20of%22%20%22parent%20directory%22' 	## Common traversal
dtdcim='intitle:%22index%20of%22%20%22DCIM%22' 					## Photo
dtftp='intitle:%22index%20of%22%20%22ftp%22' 					## FTP
dtbackup='intitle:%22index%20of%22%20%22backup%22'				## BackUp
dtmail='intitle:%22index%20of%22%20%22mail%22'					## Mail
dtpassword='intitle:%22index%20of%22%20%22password%22'			## Password
dtpub='intitle:%22index%20of%22%20%22pub%22'					## Pub
dirtravarray=("$dtparent" "$dtdcim" "$dtftp" "$dtbackup" "$dtmail" "$dtpassword" "$dtpub")
# Header
echo -e "$FontColor_Red_Bold#########################################################$NC"
echo -e "$FontColor_Red_Bold#                                                       #$NC" 
echo -e "$FontColor_Red_Bold#$NC" "$FontColor_Okegreen                   SNAKE-$NG""$FontColor_Red_Bold""RX" "$FontColor_Yellow_Bold{v$version}                 $NC" "$FontColor_Red_Bold#$NC"
echo -e "$FontColor_Red_Bold#                                                       #$NC" 
echo -e "$FontColor_Red_Bold#########################################################$NC"
echo -e ""

# Check domain
	if [ -z "$domain" ] 
	then
		echo -e "$FontColor_Okegreen# Usage example:$NC" "$FontColor_Red_Bold$0 $example_domain $NC\n"
		exit
	else
			echo -e "$FontColor_Okegreen# Get information about:   $NC" "$FontColor_Okegreen$domain$NC"
			echo -e "$FontColor_Okegreen# Delay between queries:   $NC" "$FontColor_Red_Bold$sleeptime$NC""$FontColor_Yellow_Bold sec$NC\n"
	fi

### Function to get information about site ### START
function Query 
{
		result="";
		for start in $(seq 1 35); ##### Last number - quantity of possible answers
			do
				query=$(echo; curl -sS -A $browser "https://searx.work/search?q=$site%20$1&categories=general&time_range=None&safesearch=0&pageno=$start")
				checkdata=$(echo "$query" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_~-]*$domain/[a-zA-Z0-9./?=_~-]*")
				if [ -z "$checkdata" ]
					then
						sleep $sleeptime; # Sleep to prevent banning
						break; # Exit the loop
					else
						result+=$checkdata;
						sleep $sleeptime; # Sleep to prevent banning
				fi
			done	

		sort_url=$(echo "$result" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_~-]*") 

		### Echo results
		if [ -z "$sort_url" ] 
			then
				echo -e "$FontColor_Red_Bold [-]$NC No results"
			else
				IFS=$'\n' sorted=($(sort -u <<<"${sort_url[@]}"| tr " " "\n")); # Sort the results with unique key #[X]
				echo -e " "	
				for each in "${sorted[@]}"; do echo -e "     $FontColor_Okegreen [+]$NC $each"; done
		fi
		### Unset variables
		
}
### Function to get information about site ### END


### Function to print the results ### START
function PrintTheResults
{
	for dirtrav in "$@"; 
		do echo -en "$FontColor_Red_Bold [$FontColor_Okegreen*$FontColor_Red_Bold]$NC" Checking "$(echo "$dirtrav" | cut -d ":" -f 2 | tr '[:lower:]' '[:upper:]' | sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b")" "\t" 
		Query "$dirtrav"
	done
echo " "
}
### Function to print the results ### END

# Exploit
echo -e "$FontColor_Okegreen Login Page: $NG"; PrintTheResults "${loginpagearray[@]}";
echo -e "$FontColor_Okegreen specific files: $NG"; PrintTheResults "${filetypesarray[@]}";
echo -e "$FontColor_Okegreen path traversal: $NG"; PrintTheResults "${dirtravarray[@]}";