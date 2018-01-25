# Server provisiong
This repo is meant to help automate a fresh server install, probably easier than ansible. :smile:

Chas maintains Ubuntu.sh and Mark maintains Centos.sh

## How to run?

Once you ordered your VPS, login as root, and then run this:
### ```curl -sL https://z.mk/sh | bash```

This will run the "run.sh" script directly from github, and ask you a few questions to setup your new box.

If you do not want to take advantage of an amazing SHORTURL service, then you can always run it from github directly with a nice long url.

##### ```curl -s https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/run.sh | bash```

Do not re-run the script ! It's only meant for a one-time run at the moment.

## ToDo List:
- [ ] ToDos
  - [x] Maybe seperate the scripts
  - [ ] Brush teeth
  - [x] Use a curses based menu system so you can pick and chose what you want 
  - [ ] Some way to change the user when installing the authenticator to the user that
was created during earlier part of the script

Can this do auto provision of linux kernel 

Debugging:

docker run -i -t ubuntu /bin/bash
apt-get update -y && apt-get install curl dialog -y


docker run -i -t centos /bin/bash


Interesting Notes:

curl -s http://server/path/script.sh | bash /dev/stdin arg1 arg2

curl -sL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/ubuntu.sh | bash
Things that helped:
https://askubuntu.com/questions/491509/how-to-get-dialog-box-input-directed-to-a-variable

Things that did not help:
Mark

Problems encountered:
With the curl bash method, all bash "read"s are bypassed, had to use dialog instead
