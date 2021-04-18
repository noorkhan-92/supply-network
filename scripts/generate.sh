#!/bin/bash

echo "Generating cryto material for peers..."
#[ -d crypto-config ] || mkdir ../crypto-config
#[ -d channel-artifacts ] || mkdir channel-artifacts

cryptogen generate --config=../config/crypto-config.yaml --output=../crypto-config

echo "Generating channel artifacts and genesis block..."
configtxgen -configPath ../config/ -profile SupplychainApplicationGenesis -outputBlock ../channel-artifacts/genesis_block.pb -channelID supplychannel
configtxgen -configPath ../config/ -outputCreateChannelTx ../channel-artifacts/channeltx.pb -profile SupplychainApplicationGenesis -channelID supplychannel
