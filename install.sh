#!/bin/bash

function locate {
   cwd=$(pwd)
   echo -e ""
   echo -e "---------------------"
   echo -e "current dir: $cwd"
   echo -e ""
   ls -la
   echo -e "---------------------"
   echo -e ""
}

DIR="${BASH_SOURCE%/*}"

if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

. "$DIR/PARAMETERS"
locate
. "$DIR/infra/buildhost.sh"
locate
cd restgraph/
. "$DIR/infra/getcerts.sh"
locate
cd restgraph/ 
. "$DIR/infra/server.sh"
locate
cd restgraph/ 
. "$DIR/infra/nginx.sh"
locate
cd restgraph/
. "$DIR/front/install.sh"
