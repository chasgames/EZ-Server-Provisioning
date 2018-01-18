# bash -c "$(wget -O - https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/provision.sh)"

wget https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/provision.sh -O ./prov.sh
chmod +x prov.sh
./prov.sh
