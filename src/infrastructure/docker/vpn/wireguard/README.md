# Wireguard

## Configure docker-compose file
- Replace the SERVERURL with the public IP address of your WireGuard Server, because your clients will need to connect from outside your local network. You can also set this to auto, the docker container will automatically determine your public IP address and use this in the client's configuration.
- Change the value of PEARS to specify the number of clients connected to wireguard

## Add additional clients

If you want to add additional clients, you simply can increase the PEERS parameter in the docker-compose.yml file. After changing you need to restart docker container:
```bash
docker-compose up -d --force-recreate
```