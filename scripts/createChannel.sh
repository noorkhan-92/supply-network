export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=$PWD/../crypto-config/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
export PEER0_MOFCOMCN_CA=$PWD/../crypto-config/peerOrganizations/mofcomcn.supplychain.com/peers/peer0.mofcomcn.supplychain.com/tls/ca.crt
export PEER0_MOCPK_CA=$PWD/../crypto-config/peerOrganizations/mocpk.supplychain.com/peers/peer0.mocpk.supplychain.com/tls/ca.crt
export PEER0_ICBC_CA=$PWD/../crypto-config/peerOrganizations/mocpk.supplychain.com/peers/peer0.icbc.supplychain.com/tls/ca.crt
export PEER0_ENNOBLE_CA=$PWD/../crypto-config/peerOrganizations/mocpk.supplychain.com/peers/peer0.ennoble.supplychain.com/tls/ca.crt
export PEER0_EXILE_CA=$PWD/../crypto-config/peerOrganizations/mocpk.supplychain.com/peers/peer0.exile.supplychain.com/tls/ca.crt
export PEER0_PIA_CA=$PWD/../crypto-config/peerOrganizations/mocpk.supplychain.com/peers/peer0.pia.supplychain.com/tls/ca.crt

export FABRIC_CFG_PATH=$PWD/../config/

export CHANNEL_NAME=supplychannel

# setGlobalsForOrderer(){
#     export CORE_PEER_LOCALMSPID="OrdererMSP"
#     export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../artifacts/channel/crypto-config/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
#     export CORE_PEER_MSPCONFIGPATH=$PWD/../artifacts/channel/crypto-config/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp
    
# }

setGlobalsForPeer0MOFCOMCN(){
    export CORE_PEER_LOCALMSPID="MOFCOMCNMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MOFCOMCN_CA
    export CORE_PEER_MSPCONFIGPATH=$PWD/../crypto-config/peerOrganizations/mofcomcn.supplychain.com/users/Admin@mofcomcn.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:2051
}

#setGlobalsForPeer1MOFCOMCN(){
#    export CORE_PEER_LOCALMSPID="MOFCOMCNMSP"
#    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MOFCOMCN_CA
#    export CORE_PEER_MSPCONFIGPATH=$PWD/../artifacts/channel/crypto-config/peerOrganizations/mofcomcn.supplychain.com/users/#Admin@mofcomcn.supplychain.com/msp
#    export CORE_PEER_ADDRESS=localhost:8051
    
#}

setGlobalsForPeer0MOCPK(){
    export CORE_PEER_LOCALMSPID="MOCPKMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MOCPK_CA
    export CORE_PEER_MSPCONFIGPATH=$PWD/../crypto-config/peerOrganizations/mocpk.supplychain.com/users/Admin@mocpk.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:3051
    
}

setGlobalsForPeer0ICBC(){
    export CORE_PEER_LOCALMSPID="ICBCMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ICBC_CA
    export CORE_PEER_MSPCONFIGPATH=$PWD/../artifacts/channel/crypto-config/peerOrganizations/icbc.supplychain.com/users/Admin@icbc.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:4051
    
}

setGlobalsForPeer0ENNOBLE(){
    export CORE_PEER_LOCALMSPID="ENNOBLEMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ENNOBLE_CA
    export CORE_PEER_MSPCONFIGPATH=$PWD/../artifacts/channel/crypto-config/peerOrganizations/ennoble.supplychain.com/users/Admin@ennoble.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:5051
    
}

setGlobalsForPeer0EXILE(){
    export CORE_PEER_LOCALMSPID="EXILEMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_EXILE_CA
    export CORE_PEER_MSPCONFIGPATH=$PWD/../artifacts/channel/crypto-config/peerOrganizations/exile.supplychain.com/users/Admin@exile.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:6051
    
}

setGlobalsForPeer0PIA(){
    export CORE_PEER_LOCALMSPID="PIAMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_PIA_CA
    export CORE_PEER_MSPCONFIGPATH=$PWD/../artifacts/channel/crypto-config/peerOrganizations/pia.supplychain.com/users/Admin@pia.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
    
}

createChannel(){
    #rm -rf ./channel-artifacts/*
    setGlobalsForPeer0MOFCOMCN
    
    peer channel create -o localhost:1050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.supplychain.com \
    -f $PWD/../channel-artifacts/channeltx.pb --outputBlock $PWD/../channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

removeOldCrypto(){
    rm -rf ./api-1.4/crypto/*
    rm -rf ./api-1.4/fabric-client-kv-org1/*
    rm -rf ./api-2.0/mofcomcn-wallet/*
    rm -rf ./api-2.0/mocpk-wallet/*
}


joinChannel(){
    setGlobalsForPeer0MOFCOMCN
    peer channel join -b $PWD/../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0MOKPK
    peer channel join -b $PWD/../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0ICBC
    peer channel join -b $PWD/../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0ENNOBLE
    peer channel join -b $PWD/../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0EXILE
    peer channel join -b $PWD/../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0PIA
    peer channel join -b $PWD/../channel-artifacts/$CHANNEL_NAME.block
}

updateAnchorPeers(){
    setGlobalsForPeer0MOFCOMCN
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0MOCPK
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
}

#removeOldCrypto

createChannel
#joinChannel
#updateAnchorPeers
