#!/bin/bash

OVPN_DATA="ovpn_data"
OVPN_ADDRESS=${curl -s https://api.ipify.org}

if [ $1 == "install" ]
then
        # Create an environment variable that stores the volume name:
        docker volume create --name $OVPN_DATA
        # Create OpenVPN Container
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$OVPN_ADDRESS
        # Set up Certificates
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki

elif [ $1 == "start" ]
then
        docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

elif [ $1 == "add_client" ]
then
        if [ -z $2 ]
        then
                echo "Enter the client's name with the following argument"
                exit 0
        fi

        # Generate Client Certificate
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full $2 nopass
        mkdir -p ./clients
        # Compile OpenVPN Configuration File
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient $2 > ./clients/$2.ovpn

elif [ $1 == "remove_client" ]
then
        if [ -z $2 ]
        then
                echo "Enter the client's name with the following argument"
                exit 0
        fi

        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn rm /etc/openvpn/pki/reqs/$2.req
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn rm /etc/openvpn/pki/private/$2.key
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn rm /etc/openvpn/pki/issued/$2.crt

        rm ./clients/$2.ovpn

else
        echo "You can install openvpn using this bash script. Go inside the .sh file to configure the address or docker volume vpn if necessary."
        echo "args:"
        echo "- help. Current text"
        echo "- install. Initializes ovpn"
        echo "- start. Starts ovpn"
        echo "- add_client [client_name]. Adds a new ovpn client"
        echo "- remove_client [client_name]. Deletes the ovpn client"
fi

