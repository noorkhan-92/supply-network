#!/bin/bash
ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
CORE_PEER_TLS_ENABLED=true

echo "Creating channel..."
peer channel create -o orderer.supplychain.com:1050 $ORDERER_CA -c supplychannel --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -f ../../channel-artifacts/channeltx.pb

echo 
echo "Channel created, joining Org1..."
peer channel join -b supplychannel.block
