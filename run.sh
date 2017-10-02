#!/bin/bash

./table-to-rows-mysql.sh input/public_procurement_tables | 
./columns-to-x-entity-mysql.sh product | ./run-mysql.sh | 
grep '^SELECT\|^[0-9]' | sed -e 's/SELECT COUNT(\*) \(.*\)/\1/' | 
awk '{FS="FROM ";RS="\n";OFS="\n";ORS=" ";};{$1=$1;print;}' > output/product2

./table-to-rows-mysql.sh input/public_procurement_tables | 
./columns-to-x-entity-mysql.sh customer | ./run-mysql.sh | 
grep '^SELECT\|^[0-9]' | sed -e 's/SELECT COUNT(\*) \(.*\)/\1/' | 
awk '{FS="FROM ";RS="\n";OFS="\n";ORS=" ";};{$1=$1;print;}' > output/customer2

./table-to-rows-mysql.sh input/public_procurement_tables | 
./columns-to-x-entity-mysql.sh carrier | ./run-mysql.sh | 
grep '^SELECT\|^[0-9]' | sed -e 's/SELECT COUNT(\*) \(.*\)/\1/' | 
awk '{FS="FROM ";RS="\n";OFS="\n";ORS=" ";};{$1=$1;print;}' > output/carrier2

./table-to-rows-mysql.sh input/public_procurement_tables | 
./columns-to-x-entity-mysql.sh attribute | ./run-mysql.sh | 
grep '^SELECT\|^[0-9]' | sed -e 's/SELECT COUNT(\*) \(.*\)/\1/' | 
awk '{FS="FROM ";RS="\n";OFS="\n";ORS=" ";};{$1=$1;print;}' > output/attribute2

./table-to-rows-mysql.sh input/public_procurement_tables | 
./columns-to-x-entity-mysql.sh order | ./run-mysql.sh | 
grep '^SELECT\|^[0-9]' | sed -e 's/SELECT COUNT(\*) \(.*\)/\1/' | 
awk '{FS="FROM ";RS="\n";OFS="\n";ORS=" ";};{$1=$1;print;}' > output/order2
