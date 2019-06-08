#!/bin/bash
printf " Enter the Hybris home. \n"
read -p  ""  path
commonpath="/bin/ext-commerce/solrserver/resources"
#path="/home/rhel7/Documents/HYBRISCOMM6600P/hybris/bin/ext-commerce/solrserver/resources"
path="$path$commonpath"
echo "path is $path"

cp -rf $path/solr .
rm -f startsolr.sh stopsolr.sh
touch startsolr.sh stopsolr.sh

sed -i "s#8983#4440#g" solr/server/solr/solr.xml
echo "solr/bin/solr start -c -s  solr/server/solr -p 4440" >> startsolr.sh
echo "solr/bin/solr stop -c -s  solr/server/solr -p 4440" >> stopsolr.sh

for i in `seq 3` ; 
do 
mkdir -p  solr/server/solr$i 
cp solr/server/solr/solr.xml solr/server/solr$i
sed -i "s#8983#444$i#g" solr/server/solr$i/solr.xml
#bin/solr/ start -c -s server/solr -p 444$i -z localhost:2181,localhost:2182,localhost:2183 -noprompt

echo "solr/bin/solr start -c -s  solr/server/solr -p 444$i -z localhost:3181,localhost:3182,localhost:3183 -noprompt " >> startsolr.sh 
echo "solr/bin/solr stop -c -s  solr/server/solr -p 444$i -z localhost:3181,localhost:3182,localhost:3183 -noprompt " >> stopsolr.sh 
done
chmod +x *.sh
chmod +x solr/bin/solr


