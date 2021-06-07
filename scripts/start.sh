#!/bin/bash

echo "Generating crypto materials..."
#sudo ./generate.sh
echo "Creating containers... "
docker-compose -f ../config/docker-compose.yaml up -d
echo 
echo "Containers started" 
echo 
docker ps

echo "Creating channel and join organizations"
docker exec -it cli ./scripts/createChannel.sh
#Creating channel and join org2
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/#peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" -it cli ../scripts/#channel/joinOrg2.sh
