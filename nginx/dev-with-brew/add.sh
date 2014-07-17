#!/bin/bash

#TODO: use ansible

SCRIPT_PATH=$(cd ${0%/*} && echo $PWD/${0##*/})
SCRIPT_DIR=`dirname "${SCRIPT_PATH}"`
SYS_BASE='/usr/local/etc/nginx'

function link {
    FILE=$1
    echo "link ${FILE}"
    ln -sf "${SCRIPT_DIR}/${FILE}" "${SYS_BASE}/${FILE}"
}

function enable {
    SITE=$1
    echo "enable ${SITE}"
    cd "${SYS_BASE}/sites-enabled"
    ln -sf '../sites-available/'"${SITE}" './'"${SITE}"
}

function mkdir_and_chgrp {
    DIR=$1
    echo "mkdir ${DIR}"
    mkdir -p "${DIR}"
    chgrp admin "${DIR}"
}


mkdir_and_chgrp "${SYS_BASE}"
mkdir_and_chgrp "${SYS_BASE}/sites-available"
mkdir_and_chgrp "${SYS_BASE}/sites-enabled"
mkdir_and_chgrp "/usr/local/var/log/nginx"
mkdir_and_chgrp "/usr/local/var/run/nginx"

BASE_WWW="${HOME}/Www"
mkdir -p "${BASE_WWW}/localhost"
if [ ! -f "${BASE_WWW}/localhost/public/index.html" ]; then
    echo "Add std localhost index.html"
    cp "${SCRIPT_DIR}/Www/localhost/index.html" "${BASE_WWW}/localhost/public"
fi


link nginx.conf
link mime.types
link sites-available/localhost
link sites-available/hedgehog

enable hedgehog
enable localhost

# TODO: add /etc/hosts
