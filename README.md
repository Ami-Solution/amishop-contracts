<img align="left" src="https://raw.githubusercontent.com/amisolution/ERC20-AMIS/master/amis-logo3.png" alt="amis-logo3"/>
<img align="right" src="https://raw.githubusercontent.com/amisolution/ERC20-AMIS/master/images/AMIS-QRCODE.png" alt="AMIS-QRCODE" width="100"/>

[![Website Down](https://img.shields.io/badge/website-down-red.svg)](http://erc20-amis.amisolution.net/)&nbsp;
[![Join the Gitchat at https://gitter.im/amis-delta-dex/Lobby](https://badges.gitter.im/amis-delta-dex/Lobby.svg)](https://gitter.im/AMIS-DELTA-DEX/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)&nbsp;[![Trade Bounty](https://img.shields.io/badge/trade-bounty-orange.svg)](https://github.com/amisolution/ERC20-AMIS/issues/)&nbsp;[![Twitter AirDrop](https://img.shields.io/badge/Twitter-Airdrop-red.svg)](https://twitter.com/AMIStoken_ERC20)&nbsp;[![Official Twitter](https://img.shields.io/badge/official-twitter-brightgreen.svg)](https://twitter.com/amis_erc20)&nbsp;[![Official AmisForkdelta](https://img.shields.io/badge/official-forkdelta-brightgreen.svg)](https://forkdelta.app/#!/trade/0x949bed886c739f1a3273629b3320db0c5024c719-ETH)
&nbsp;[![Official AmisEtherDelta](https://img.shields.io/badge/official-etherdelta-brightgreen.svg)](https://etherdelta.com/#0x949bed886c739f1a3273629b3320db0c5024c719-ETH)
&nbsp;[![Official BambooRelay](https://img.shields.io/badge/official-bamboorelay-brightgreen.svg)](https://bamboorelay.com/trade/AMIS-WETH)&nbsp;[![Official AmisTokenJar](https://img.shields.io/badge/official-tokenjar-brightgreen.svg)](https://tokenjar.io/amis)
&nbsp;[![ßtesting Dubiex](https://img.shields.io/badge/ßtesting-dubiex-yellow.svg)](https://dubiex.com/AMIS/ETH)&nbsp;[![Official AmisLedgerDex](https://img.shields.io/badge/official-ledgerdex-1330e3.svg)](https://app.ledgerdex.com/#/app/orders/maker-taker/AMIS/0x949bed886c739f1a3273629b3320db0c5024c719/WETH/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
)&nbsp;[![Official Cryptoderivatives](https://img.shields.io/badge/official-cryptoderivatives-4330e7.svg)](https://cryptoderivatives.market/token/AMIS)&nbsp;[![Official Cryptocompare](https://img.shields.io/badge/official-cryptocompare-brightgreen.svg)](https://www.cryptocompare.com/coins/amis)&nbsp;[![Official DexTracker](https://img.shields.io/badge/official-dextracker-brightgreen.svg)](https://etherscan.io/dextracker?filter=&q=AMIS)
&nbsp;[![ßtesting TokenStore](https://img.shields.io/badge/ßtesting-TokenStore-yellow.svg)](https://token.store/trade/0x949bed886c739f1a3273629b3320db0c5024c719)
&nbsp;[![αtesting EthenMarket](https://img.shields.io/badge/αtesting-ethenmarket-lightgrey.svg)](https://ethen.market/949bed886c739f1a3273629b3320db0c5024c719)&nbsp;[![ßtesting AmisDex](https://img.shields.io/badge/ßtesting-amisdex-lightblue.svg)](https://amisdex.github.io/amis-exchange-www)&nbsp;
[![Build Status](https://travis-ci.com/ami-solution/amisjs.svg?token=xxxx&branch=master)](https://travis-ci.com/ami-solution/amis.js) ![npm](https://img.shields.io/npm/v/amishop-contracts.svg)


**[https://amishop.glitch.me](https://amishop.glitch.me)**


What is AmiShop ?

# AmiShop -  Smart contracts for shopping with Ethereum and Amis.

[![Join the chat at https://gitter.im/erc20-amis/Lobby](https://badges.gitter.im/ami-solution/amishop.svg)](https://gitter.im/erc20-amis/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)



### Version 0.1.0b    
This version is the MVP version, its not suppose to reflect our entire version describe in our white paper.    
What this version is supposed to do:    
Allow shop and teller to add geolocalised point, to be visible by user reading smart contract.      
For teller to have the possibility to sell ETH.
The map is cut in zone https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2    
And we store address of shop and teller in a mapping country => postal Code:   
`mapping(bytes2 => mapping(bytes16 => address[])) shopInZone;`    
This way someone could easily get all the shop in his postalcode by just call the function:    
```
function getZoneShop(bytes2 _country, bytes16 _postalcode) public view returns (address[]) {
   return shopInZone[_country][_postalcode];
}
```
He could then loop on the function getShop with all the address he gets from this previous function:    
```
function getShop(address _shop) public view returns (
 int32 lat,
 int32 lng,
 bytes2 countryId,
 bytes16 postalCode,
 bytes16 cat,
 bytes16 name,
 bytes32 description,
 bytes16 opening
 ) {
  Shop storage theShop = shop[_shop];
  lat = theShop.lat;
  lng = theShop.lng;
  countryId = theShop.countryId;
  postalCode = theShop.postalCode;
  cat = theShop.cat;
  name = theShop.name;
  description = theShop.description;
  opening = theShop.opening;
 }
```   
This smart contract is supposed to be used just like that by the most Dapps possible to show their user where they could spend their crypto or buy or sell cryptos.    
We keep moderator roles contralised for now, but we will use decentralised arbitration court later to be able to delete illegal shop for example.    
To be able to register a shop or a teller, the ethereum user need to be `certified` we keep this role centralised as well for now but we'll use decentralised KYC services like uport soon.    
To become a certified subscriber will either need to register their phone, or pass KYC.    
To operate on a zone a shop or a teller will need to stake AMIS. The price will differ among zone and will be automatically calculated by the smart contract regarding different parameter like localisation, number of teller or shop already present. For now the price a user need to stake is set by the free decentralized marketplace as exposed in all the exchange offering Amis.    

* The role of a Centralized moderator will be introduced with the v0.1.0b release: 
**Main actions:**
-Set the licence price.
-Delete fraudulent shop/teller.    
-Open/close zone (country).    
-Certify user to be able to register.    

To be integrated on the futures versions:   
-Loyalty program     
-Affiliate/referal program   
-Auction system on zone and category.  
-Dynamic licence pricing    
-Decentralized moderation.    
-Decentralized KYC    

Upgradable VS non-upgradable    
Some of these smart contracts may not be upgradable, only the funds and certification are due to reside on a separate contract which is upgrable, but for the data structure and the logic, we believe that many changes will come into play, so we keep things simple and cheaper in gas by having logic and data in the smart contract.    
If someone registers a new point of Sale (POS) on the outdated contract during migration phase, a manual load with all deltas may have to be reprocessed onto the new smart contract.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Table of Contents

* [Install](#install)
* [Docs](#doc)
* [Function call](#function call)
* [Test](#test)
* [Deploy](#deploy)
* [Contributing](#dependencies)
* [Authors](#bugs)
* [Licence](#licence)
* [Donation](#donation)


## Install
This repo its a truffle project, you first need to have truffle installed.
And then install all the dependencies
```
npm install
truffle install bytes
```

## Docs

Coming soon

## Function call

### Register a shop or a teller
You need to call:
`function transfer(address _to, uint _value, bytes _data) public returns (bool);`
Of the AMIS contract with the address of AmishopCore as a parameter

#### Inputs

* `address _to`: AmishopCore address
* `uint _value`: At least the licence price for your zone
* `bytes _data`: Formatted list of arguments
* Data classification for shops, stores, retailers and Point of Sale:

| PARAM       | BYTES NUMBERS | value                                                                                                                                                                                                    | value in hex                                                     |
|-------------|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| category    | 1st           | 1 for shop                                                                                                                                                                                               | 0x31                                                             |
| Latitude    | 5 bytes       | latitude * 10000 => if first bytes is 0x01 the value will be negative if not positive, then Hex value padded in 4 bytes - We keep 5 digit for the latitude parameter - So we need to multiply the parameter byt 10000 to store it on the EVM Exemple: 36.14081 * 10000 = 3614081 | 00496E39                                                         |
| Longitude   | 5 bytes       | longitude * 10000 => if first bytes is 0x01 the value will be negative if not positive, then Hex value padded in 4 bytes - We keep 5 digit for the longitude parameter - So we need to multiply the parameter byt 10000 to store it on the EVM Exemple:5.35360 * 10000 = 535360  | 000386BB                                                         |
| CountryID   | 2bytes        | -Country Code ID. We use the ISO ALPHA 2 format: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 Ex for Gibraltar: GI                                                                                   | 4749                                                             |
| PostalCode  | 16bytes       | -Postal code value in ascii Hex, padded in 16 bytes Exemple for Gibraltar: GX11 1AA                                                                                                                      | 475831312031414100000000000000000000                             |
| Category    | 16bytes       | -Catogory value in ascii Hex, padded in 16 bytes. The category will be use for the search engine, and for the keyword staking keyword. Exemple: restaurant                                               | 72657374617572616e74000000000000                                 |
| Name        | 16bytes       | Name of the shop, in ascii Hex, padded in 16 bytes. Exemple: Cool shop                                                                                                                                   | 436f6f6c204a6f620000000000000000                                 |
| Description | 32bytes       | Description of the shop, in ascii Hex, padded in 32 bytes Exemple: I sell cool things for ETH                                                                                                            | 492073656c6c20636f6f6c207468696e677320666f7220455448000000000000 |


So the final `_data` parameter will looks like:
0x3100496E39000386BB47494758313120314141000000000000000072657374617572616e74000000000000436f6f6c204a6f620000000000000000492073656c6c20636f6f6c207468696e677320666f7220455448000000000000
this hex string will be parsed on the fallback fonction of the AmishopCore

* FOR TELLER

| PARAM       | BYTES NUMBERS | value                                                                                                                                                                                                    | value in hex                         |
|-------------|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| category    | 1st           | 2 for teller                                                                                                                                                                                             | 0x32                                 |
| Latitude    | 4 bytes       | latitude * 10000 => Hex value padded in 4 bytes - We keep 5 digit for the latitude parameter - So we need to multiply the parameter byt 10000 to store it on the EVM Exemple: 36.14081 * 10000 = 3614081 | 00496E39                             |
| Longitude   | 4 bytes       | longitude * 10000 => Hex value padded in 4 bytes - We keep 5 digit for the longitude parameter - So we need to multiply the parameter byt 10000 to store it on the EVM Exemple:5.35360 * 10000 = 535360  | 000386BB                             |
| CountryID   | 2bytes        | -Country Code ID. We use the ISO ALPHA 2 format: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 Ex for Gibraltar: GI                                                                                   | 4749                                 |
| PostalCode  | 16bytes       | -Postal code value in ascii Hex, padded in 16 bytes Exemple for Gibraltar: GX11 1AA                                                                                                                      | 475831312031414100000000000000000000 |
| AvatarID    | 1 byte        | -AvatarID for the front-end app, number in hexa -Value could be anything between 1-10 currently exemple : 1                                                                                              | 31                                   |
| CurrencyID  | 1 byte        | Number between 1 and 100 cf annexe1. Ex: 1 (= USD)                                                                                                                                                       | 31                                   |
| messengerID | 16bytes       | Nickname telegram to be contacted. In Ascii Hex value padded in 16 bytes. Ex: if the link of a telegram user is http://t.me/user1 , this user should put user1 in the field. Exemple: user1              | 75736572310000000000000000000000     |
| rates       | 2 bytes       | Margin the ETH seller want to take from his trade, the value should be multiplied by 10 to keep a decimal when stored in EVM. Exemple: 5.6 % => 56 in hex padded in 2 bytes                              | 0038                                 |


The final `_data`value will looks like:
0x3200496E39000386BB47494758313120314141000000000000000000003131757365723100000000000000000000000038 this hex string will be parsed on the fallback fonction of the DetherCore   

### Update a teller
A teller can update his data, however he can't move his location, if he want to do this he will have to delete his sell point, and then to recreate a new one.
```javascript
UpdateTeller()
```
#### Inputs

* `currencyId`: int8 - cf annexe1 for table of Currency
* `messenger`: telegram nickname (max 16 bytes)
* `avatarId`: 1 - 100 value for avatar
* `rates`: margin seller want to take * 10, for 8.7%, put 87
* `online`: true if teller want to stay visible, false if teller want to pass offline
* `PAYABLE FUNCTION`, you can send ETH during transaction.

### (TODO add other fonction)

## Test  

Test are located on the test/ folder, you can run it in the truffle console directly

```
truffle develop
test
```

## deploy
You need to have an .env files with valid mnemonic phrase with ETH:
```
MNEMONIC = "xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx"
```
Then deploy (on kovan, ropsten):
```
truffle migrate --network kovan
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **Mehdi Amari** - [Fukunaga42](https://github.com/Fukunaga42)
* **Stéphane Roche** - [Janaka-Steph](https://github.com/Janaka-Steph)
* **Amisolution** - [Amisolution](https://github.com/amisolution)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Donation
* [Ethereum Foundation](https://ethereum.org/donate)
* [Etherscan](https://etherscan.io/address/0x71c7656ec7ab88b098defb751b7401b5f6d8976f)
* [MyEtherWallet](https://etherscan.io/address/0x7cB57B5A97eAbe94205C07890BE4c1aD31E486A8)
* [CoinMarketCap](https://etherscan.io/address/0x0074709077B8AE5a245E4ED161C971Dc4c3C8E2B)
