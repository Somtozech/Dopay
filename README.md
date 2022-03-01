# DOPAY 
This project demonstrates how to build an oracle, aggregator and an ECR20 Token contract 

## Aggregator Contract
The aggregator contract inherits the oracle contract and stores the latest ethereum price in USD. The Ethereum price is updated by an off chain server every 5 minutes.

## DoPay Token Contract
This an ERC20 token, Basically maintains a fixed price in USD (for demo purposes). You can swap this token with Eth. 