#!/bin/bash
# Использование:
#  start-ssh-tunnel.sh SSH-HOST
# где SSH-HOST - какой-нибудь SSH хост, где github доступен.
# Рекомендуется сначала сделать работу с этим хостом по ключам.
#
# После выполнения всех действий https://github.com/ должен будет заработать в браузерах.
# Для SSH доступа к github репозиториям возможно нужно будет использовать особый порт.

if [[ -z $1 ]]; then
    echo "usage `basename $0` SSH-HOST"
    exit 1
fi

BIND='127.0.0.1'
SSHPORT='22222'
SSH_CFG="$HOME/.ssh/config"
GITHIB_HOST='192.30.252.128'

if [[ `uname` == 'Darwin' ]]; then
    echo -n "Add 127.0.0.2 to lo0 interface and use it for bind? [n/Y] "
    read Y
    if [[ "${Y}" == "y" || "${Y}" == "Y" ]];then
        sudo ifconfig lo0 add 127.0.0.2
        BIND='127.0.0.2'
        SSHPORT='22222'
    fi
fi


sudo -E ssh -N -C -c blowfish -f -F "${SSH_CFG}" -L "${BIND}:443:${GITHIB_HOST}:443" "${1}"
sudo -E ssh -N -C -c blowfish -f -F "${SSH_CFG}" -L "${BIND}:${SSHPORT}:${GITHIB_HOST}:22" "${1}"

echo "Check tunnels:"
ps aux | grep 'ssh -N -C -c blowfish -f -F'
echo ""

echo -e "Add to /etc/hosts\n${BIND} github.com\n\n"
if [[ $SSHPORT != "22" ]];then
    echo -e "Add to ~/.ssh/config\nHost github.com\n   Port ${SSHPORT}"
fi
echo ""

echo "You can stop tunneling by:"
echo "sudo pkill -f 'ssh -N -C -c blowfish -f -F'"
