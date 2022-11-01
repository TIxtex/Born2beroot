#!/bin/bash
# monitoring.sh author:Tixtex #

show_arch() {
	echo "#Architecture: $(uname -a)" 
}

show_cpu() {
	echo "#CPU physical : $(nproc)"
}

show_vcpu(){
	echo "#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)"
}

show_ram() {
	T=$(free -t --mega | grep Total: | awk '{print $2}')
	U=$(free -t --mega | grep Total: | awk '{print $3}')
	F=$(free -t --mega | grep Total: | awk '{print $4}')
	P=$(echo "scale=2; $U * 100 / $T" | bc)
	echo "#Memory Usage: $U/$T""MB ($P%)"
}

show_du() {	
	T=$(df -h --total | grep total | awk '{print $2}')	
	U=$(df -h --total | grep total | awk '{print $3}')	
	P=$(df -h --total | grep total | awk '{print $5}')	
	echo "#Disk Usage: $U/$T ($P)"
}

show_cpu_l() {
	P=$(top -n1 | grep %Cpu | awk '{print $2}')
	echo "#CPU load: $P%"
}

show_lb() {
	echo "#Last boot: $(uptime -s)"
}

show_lvm() {
	if ls /dev/mapper/ | grep -i LVM >/dev/null ; then
		echo "#LVM use: yes"
	else
		echo "#LVM use: no"
	fi
}

show_tcp() {
	echo "#Connections TCP : $(ss -s | grep TCP: | cut -d : -f2)"
}

show_user_num() {
	echo "#User log: $(cat /etc/passwd | wc -l)"
}

show_ip_mac() {
	A=$(ip a s enp0s3 | grep 'inet ' | cut -d ' ' -f6)
	B=$(ip a s enp0s3 | grep 'ether' | cut -d ' ' -f6)
	echo "#Network: IP $A ($B)"
}

show_sudo() {
	N3=$(journalctl _COMM=sudo | wc -l)
	N=$(echo "scale=0; $N3 / 3" | bc)
	echo "#Sudo : $N"
}

show_arch
show_cpu
show_vcpu
show_ram
show_du
show_cpu_l
show_lb
show_lvm
show_tcp
show_user_num
show_ip_mac
show_sudo

# !/bin/bash

