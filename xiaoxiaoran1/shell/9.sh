#!/usr/bin/expect

set ip 192.168.100.1 #set ip [lindex $argv 0]
set user root  #set user [lindex $argv 1]
set password xiaoxiaoran
set timeout 5

spawn ssh $user@$ip
spawn scp -r /etc/hosts $user@$ip:/tmp

expect {
	"yes/no" { send "yes\r"; exp_continue }
	"password:" {send "$password\r"}
}

# interact 

expect "#"

send "useradd xiao\r"
send "pwd\r"
send "exit\r"

expect eof 


