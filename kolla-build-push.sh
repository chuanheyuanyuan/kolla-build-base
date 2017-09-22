#! /bin/bash

expect -c "
spawn ssh-keygen 
expect { 
	\"file in which to save the key\" {
		send \"\n\r\"
		exp_continue
	}
	\"*Enter passphrase*\" {
		send \"\n\r\"
		exp_continue
	}
	\"*Enter same passphrase again*\" {
		send \"\n\r\"
		exp_continue
	}
}


ip=47.91.244.5
password=Weichuanzi@123456

expect -c "
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$ip
expect {
	\"*Are you sure you want to continue connecting*\" {
		send \"yes\r\"
		exp_continue
	}
	
	\"*password*\" {
		send \"$password\r\"
		exp_continue
	}
}
"

sed -i 's%ExecStart=/usr/bin/dockerd.*%ExecStart=/usr/bin/dockerd -s vfs --insecure-registry 47.91.244.5:4000%g' /usr/lib/systemd/system/docker.service

systemctl daemon-reload
systemctl start docker

tools/build.py -t source --skip-parents --skip-existing

a=($(docker images |grep ^kolla|awk '{print $1":"$2}'|awk -F '/' '{print "47.91.244.5:4000/kolla/"$2}'))
b=($(docker images |grep ^kolla|awk '{print $1":"$2}'))
for((i=0;i<${#a[@]};i++));
do  
docker tag ${b[$i]} ${a[$i]} ;
docker push ${a[$i]};
done


