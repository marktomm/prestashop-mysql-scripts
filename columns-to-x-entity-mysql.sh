#!/bin/bash

#
# $0 input_file entity
# input | $0 entity
# $0 entity < input
# $0 entity <<< EOF
#   input
# EOF
# 
# expects column info as input from stdin
# input example:
# message_readed message employee
# meta meta
# meta_lang meta
# 
# first word is table name,
# subsequent are its
# 
# entity example:
# category
# product
# 
# anything that has id_prefix in prestashop db colmuns
#

source config/default

set -eo pipefail

[[ $# -eq 0 ]] && {
    echo "error"
    exit 1;
}

columns_to_x_entity_mysql() {
    
local mysqlcmd='SELECT COUNT(*) FROM ps_'
[[ ! -z ${PS_MYSQL_CMD} ]] && {
    mysqlcmd="${PS_MYSQL_CMD}"
}

local entity="${@: -1}"
local inp="${PS_INPUT_FILE}"

[[ $# -eq 1 ]] && {
    unset PS_INPUT_FILE
    inp="$(cat)"
}
# local cmd="grep -F ${entity} "

local out="";
local post_cmd="awk '{print \$1}'"

[[ -z ${PS_INPUT_FILE} ]] && {
#     cmd=$(echo "${cmd} <<EOF ${inp}
# EOF
# ")

# grep -F "${entity}" <<zzz23EndOfMessagezzz23
# ${inp}
# zzz23EndOfMessagezzz23

    # ${out}=$(echo "${inp}" | grep -F "${entity}" | ${post_cmd} )
    out="$(echo "${inp}" | grep -F "${entity}" | awk '{print $1}' | sed "s/\(.*\)/${mysqlcmd}\1;/")"
} || {
    # cmd=$(echo "${cmd} ${inp}")
    :
    # ${out}=$(grep -F ${entity} ${inp} | ${post_cmd} )
    out="$(grep -F ${entity} ${inp} | awk '{print $1}' | sed "s/\(.*\)/${mysqlcmd}\1;/")"
    # echo "here@"
#     sed -e "s/${entity}/\L&/g" <<EOF2
# ${out}
# EOF2
}

echo ${out}

# eval "${cmd}"
# | while read -r line; do
#     echo "$line"
# done



}

columns_to_x_entity_mysql "$@"
