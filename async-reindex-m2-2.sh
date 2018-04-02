#!/bin/bash
#Author: Nemanja Djuric
#Script to speed up Magento 2 indexer execution. NOTE: Ajust PHP name, if necessarry.

#!/bin/bash

if [[ -e app/etc/env.php ]]; then

i=0
input=$(php bin/magento indexer:info | awk {'print $1'})
 
echo "Resetting indexers"
reset=$(php bin/magento indexer:reset)
echo ${reset}
 
while IFS= read -r line; do
    echo "starting $line index in screen"
    $(screen -mdS screen$i php bin/magento -d memory_limit=-1 indexer:reindex $line)
    ((i++))
done <<< "$input"

else

echo "please cd into installation directory"

fi
