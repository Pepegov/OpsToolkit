# OUTLINE

## Server

[Project](https://getoutline.org) | [Server-git](https://github.com/Jigsaw-Code/outline-server) | [Dockumentation](https://docs.getoutline.com/s/hosting)

Minimum system requirements:
- 1 CPU core.
- 1 GB of RAM (or less).
- 10 GB HDD for OS files mostly.

Firewall settings:
```bash
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp
#optional
sudo ufw allow 39885/tcp
sudo ufw allow 1586/tcp
sudo ufw allow 1586/udp
```

Download install script and install outline (or use copy in current folder)
```bash
sudo wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh | bash
```
Docker, WatchTower, and Outline services will be installed. If necessary, you can install Docker yourself before running the script.

If the script completes the installation correctly, the key for configuring the server will appear
```json
{ 
  "apiUrl": "https://0.0.0.0:0000/XXXXXXXXXXXX", 
  "certSha256": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 
}
```

## Manager

In the Outline [Manager](https://getoutline.org/en/get-started/#step-1), we add a new key in the server management. The program will show a link to the instructions and the key itself as a string:
```
ss://XXXXXXXXXXXX@9.9.9.9:0/?outline=1
```

direct link: https://s3.amazonaws.com/outline-releases/manager/linux/stable/Outline-Manager.AppImage

## Client

Install the client to connect.
At the first launch, you need to click "Add server" and insert the key received above.

direct links:
- IOS: https://itunes.apple.com/app/outline-app/id1356177741
- macOS: https://itunes.apple.com/app/outline-app/id1356178125
- Windows: https://s3.amazonaws.com/outline-releases/client/windows/stable/Outline-Client.exe
- Linux: https://s3.amazonaws.com/outline-releases/client/linux/stable/Outline-Client.AppImage
- Android: https://play.google.com/store/apps/details?id=org.outline.android.client
- Addition Android link: https://s3.amazonaws.com/outline-releases/client/android/stable/Outline-Client.apk
