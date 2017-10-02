#!/bin/bash

#
# $0 input_file
# input | $0
# $0 < input
# $0 <<< EOF
#   input
# EOF
# 
# input example:
# ps_category
# ps_category_group
# ps_category_product
#

# set -eo pipefail

source config/mysql-default

table_to_rows_mysql() {
    
local inp="${PS_INPUT_FILE}"
local out="${PS_OUTPUT_FILE}"
local tmp="${PS_TMP_FILE}"

local usr="${PS_MYSQL_USER}"
local pss="${PS_MYSQL_PASS}"
local hst="${PS_MYSQL_HOST}"
local db="${PS_MYSQL_DATABASE}"
local cmd="${PS_MYSQL_COMMANDS_FILE}"

# local table_name_arr=()
# local mysql_cmd_arr=()

local mysql_cmd_str="";

while read -r table_name; do
    [[ ! -z "${table_name}" ]] && {
        export table_name="${table_name}"
        var="$(envsubst < ${cmd})"
        mysql_cmd_str=$(echo "${mysql_cmd_str} ${var}");
        
        # table_name_arr+=("${table_name}")
        # mysql_cmd_arr+=$(envsubst < ${cmd})
        # echo "${mysql_cmd_arr[-1]}"

        # echo "%${table_name}:"
#         mysql -v --host=${hst} --user=${usr} --password=${pss} ${db} 2>>${PS_MYSQL_LOG_FILE} <<ENDXXX | grep '^show columns from \|^id_'
#             $(envsubst < ${cmd})    
# ENDXXX
    }
done < ${inp} 
# > ${tmp}
# > ${out}

# echo ${mysql_cmd_str}
mysql -v --host=${hst} --user=${usr} --password=${pss} ${db} 2>>${PS_MYSQL_LOG_FILE} <<ENDXXX | grep '^show columns from \|^id_' | grep -v 'id_lang\|id_shop' | sed -e 's/show columns from \(.*$\)/\1/' -e 's/\(id_[a-zA-Z0-9_]*\).*$/\1/' | awk 'BEGIN{FS="\nid_";OFS=" ";RS="ps_";ORS="";} ; {$1=$1;print}'
    ${mysql_cmd_str}   
ENDXXX

exit 0
# awk 'BEGIN{FS="\nid_";OFS=" ";RS="%";ORS="";} ; {$1=$1;print}' ${tmp}
# | tail -n +2 | awk '{print $1}' | grep ':$\|^id_' | grep -v 'id_lang\|id_shop'
}

table_to_rows_mysql "$@"
