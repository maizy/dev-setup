#!/usr/bin/env bash
#
# Reinstall db macports packages
#

sudo port install \
    postgresql92 \
    postgresql92-server \
    postgresql_select \
    py26-psycopg2 \
    py27-psycopg2 \
    py32-psycopg2 \
    py33-psycopg2
    # mysql55 \
    # mysql55-server \
    # mysql_select \
