
OIQ Script Installtion

1) Download the OIQAgentsScript.sh file 
2) Give the permissons to execute like 
   chmod +X OIQAgentsScript.sh


For Tomcat agent reqirements

3) Enable tomcat jmx port and tomcat-server in running mode

4)Run the file in command prompt like
   ./OIQAgentsScript.sh       (hit Enter)
   

5)Script will ask  yes|no quetions for installation 

6) if jmx port not enabled then the script will enable tomcat jmx port and stoped the running tomcat-server.
7) In command prompt run below command 
      source /etc/environment
8) start tomcat-server in your location.

9)Again run the file in command prompt like
   ./OIQAgentsScript.sh       (hit Enter)

 
10)Script will ask configuration details like tomcat host, port and jmx port
after entering details script will give success message.

For mysql agent reqirements

11)mysql-server is in running mode 

12)Script will ask configuration details like mysql host , port , username and password
after entering details script will give success message.

logstash requirements

13)After downloading the logstash.
open the /etc/logstash/conf.d/opsmx-oiq.conf file in your preferred editor 
then  replace "/root/oiq/logs/services-ddiq.log" with your log files absolute path, if there are multiple give comma separated "log1","log2"
and replace timezone with current machine timezone in format "+05:30" 

save it! 

14) Restart logstash run below command in terminal.
 service logstash logstash



