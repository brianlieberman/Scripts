#!/usr/bin/expect

#Changes the connected master device for the AMX virtual panel
#Takes two commandline parameters: system number and IP
#Brian Lieberman
#11/12/14

###SANITIZED###

set timeout 20
set number [lindex $argv 0]
set ip [lindex $argv 1]


spawn telnet xxx.xxx.xxx.xxx
expect ">"
send "set connection\r"
expect "Enter protected password:"
send "xxxx\r"
expect "Type E for Ethernet or I for ICSNet and the enter:"
send "e\r" 
expect "Type U for URL, L for Listen,or A for Auto and then Enter:"
send "u\r"
expect "Enter Master System Number:"
send "$number\r" 
expect "Enter Master IP/URL:" 
send "$ip\r" 
expect "Enter Master Port:" 
send "\r"
expect "Enter Master User:"  
send "\r"
expect "Enter Master Password:" 
send "\r"
expect "Is this correct? Type Y or N and Enter ->" 
send "y\r"
expect ">"
send "reboot\r"
expect "Enter protected password:"
send "xxxx\r"

