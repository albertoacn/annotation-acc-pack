set -e

curl -O http://solutions-tokbox.tid.es:8080/jnlpJars/jenkins-cli.jar

java -jar jenkins-cli.jar -s http://solutions-tokbox.tid.es:8080/ build RegionsTest -s --username "" --password "" | grep ' : SUCCESS' &> /dev/null
if [ $? != 0 ]; then
   exit 1
fi
