# Server provisiong
This repo is meant to help automate a fresh server install, probably easier than ansible. :smile:

## How to run?

### ```curl -sL https://z.mk/sh | bash```

This will run the "run.sh" script directly from github, and ask you a few questions to setup your new box.

soon to install docker 


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

Things that helped:
https://askubuntu.com/questions/491509/how-to-get-dialog-box-input-directed-to-a-variable

Things that did not help:
Mark

Problems encountered:
With the curl bash method, all bash "read"s are bypassed, had to use dialog instead
