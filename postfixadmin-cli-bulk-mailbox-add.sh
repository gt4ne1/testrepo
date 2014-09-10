#!/bin/bash

###################################################################################
# Bulk mailbox add using postfixadmin-cli tools.
#
# Read file
# For each line in file call command and pass comma separated values as options to command
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#


IFS=','
while read col1 col2 col3 col4 col5;
do
        #echo "I got:$col1|$col2|$col3|$col4|$col5"
        /usr/share/postfixadmin/scripts/postfixadmin-cli mailbox add $col1 --password $col2 --password2 $col3 --name $col4 --quota $col5 --active --welcome-mail n
done < myspeedwayracer.com.csv