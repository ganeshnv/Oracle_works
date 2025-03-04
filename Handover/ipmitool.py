import json
import paramiko
import time
import getpass
from paramiko import SSHClient

ilom_file = open('C:\\Users\\nedupall\\Desktop\\OCIC-SUPPORT_PROJECT\\Project_Automation\\ilomhardwaredetails.json','r', encoding='utf-8')
host_file = open('C:\\Users\\nedupall\\Desktop\\OCIC-SUPPORT_PROJECT\\Project_Automation\\zonedetails.json','r',encoding='utf-8')
ilom_data = json.load(ilom_file)
host_data = json.load(host_file)
list_bastion=[]
list_management=[]  
zone_name=''
ilom_ip = input("Enter Ilom IP :")
for r in ilom_data["response"]:
    if ilom_ip in r["ilom"]:
        print("Zone Name for the ILOM is:",r["zone"])
        zone_name = (r["zone"])
        print(zone_name)

for h in host_data["response"]:
    if zone_name in h["zone"]:
        b_host=(h["linux_bastion_host"])
        m_host=(h["management_host"])
list_bastion = b_host.split(",")
list_management = m_host.split(",")
print("Bastion_Host:"+' '+ str(list_bastion[0]) +'\n'+"Management_Host:"+' '+ str(list_management[0]))

ssh = paramiko.SSHClient()
server_bastion = "chi1-c-ad1-bastion-01.us2.oraclecloud.com"
server_managemnent="cqclc10r326ru17.usdc2.oraclecloud.com"
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(server_bastion,22,username="nedupall",password=input())
print("Bastion Host Connected successfully")
stdin, stdout, stderr = ssh.exec_command("pwd")
print({stdout.read().decode()})
ssh.exec_command("ssh cqclc10r326ru17.usdc2.oraclecloud.com")
ssh.exec_command("PardhuVihan@2022")
print("Management Host Connected successfully")
time.sleep(1)
stdin, stdout, stderr = ssh.exec_command("pwd")
print({stdout.read().decode()})
time.sleep(2)
channel = ssh.get_transport().open_session()
channel.get_pty()
channel.invoke_shell()
while True:
    command = input('$ ')
    if command == 'exit':
        break
    stdin, stdout, stderr = ssh.exec_command(command + "\n")
    print({stdout.read().decode()})
    print({stderr.read().decode()})


'''
ssh.exec_command("IuaJiYPBaU")
#stdin, stdout, stderr = ssh.exec_command("show /SYS/ power_state")
output=stderr.read()
output1=stdout.read()
print(output)
print(output1)'''
#client.close()print
ssh.close()