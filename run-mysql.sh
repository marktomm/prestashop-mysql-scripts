#!/bin/bash

source config/mysql-default

run_mysql() {

local inp=""

[[ -f ${PS_INPUT_FILE} ]] && {
    inp="$(cat ${PS_INPUT_FILE})"
} || {
    inp="$(cat)"
}

mysql -v --host=${PS_MYSQL_HOST} --user=${PS_MYSQL_USER} --password=${PS_MYSQL_PASS} ${PS_MYSQL_DATABASE} 2>>${PS_MYSQL_LOG_FILE} <<ENDXXX
${inp}
ENDXXX

}

run_mysql "$@"
