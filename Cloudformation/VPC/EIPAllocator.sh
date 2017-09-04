"#!/bin/sh","\n",
"MAC=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/`","\n",
"#Use for default nic ENIID=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$MAC/interface-id/`","\n",
"ENIID=",{ "Ref": "NATInstanceENI" },"\n",
"INSTANCEID=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id`","\n",
"ALLOCATIONID=",{ "Fn::GetAtt": [ "NATEIP", "AllocationId" ] },"\n",
"#Attaches to the default network interface of the instance aws ec2 --region us-east-1 associate-address --network-interface-id $ENIID --allocation-id $ALLOCATIONID","\n",
"aws ec2 --region ",{ "Ref": "region" }, attach-network-interface --network-interface-id $ENIID --instance-id $INSTANCEID --device-index 1","\n",
"aws ec2 --region ",{ "Ref": "region" }, associate-address --network-interface-id $ENIID --allocation-id $ALLOCATIONID","\n",
