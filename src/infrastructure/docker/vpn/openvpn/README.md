# OpenVPN

## Script install

You can install openvpn using this bash script. Go inside the .sh file to configure the address or docker volume vpn if necessary.
        
**args:**
- help. Current text"
- install. Initializes ovpn"
- start. Starts ovpn"
- add_client [client_name]. Adds a new ovpn client"
- remove_client [client_name]. Deletes the ovpn client"

## Manual install

Create an environments variable that stores the volume name and server address:
```bash
OVPN_DATA="ovpn-data"
OVPN_ADDRESS=${curl -s https://api.ipify.org}
```

Create an environment variable that stores the volume name:
```bash
docker volume create --name $OVPN_DATA
```

Create OpenVPN Container
```bash 
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$OVPN_ADDRESS
```

Set up Certificates
```bash
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
```

Start ovpn
```bash
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
```

Generate Client Certificate
```bash
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full  [client_name] nopass
```

Compile OpenVPN Configuration File
```bash
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient  [client_name] >  [client_name].ovpn
```