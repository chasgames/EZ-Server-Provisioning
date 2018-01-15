#!/bin/bash

distro=$(lsb_release -i | cut -f 2-)

echo $distro
