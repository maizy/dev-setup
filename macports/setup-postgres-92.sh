#!/usr/bin/bash

sudo mkdir -p /opt/local/var/db/postgresql92/defaultdb
sudo chown postgres:postgres /opt/local/var/db/postgresql92/defaultdb
sudo su postgres -c '/opt/local/lib/postgresql92/bin/initdb -D /opt/local/var/db/postgresql92/defaultdb'