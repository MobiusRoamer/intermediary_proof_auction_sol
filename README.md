# Ethereum Auction dApp (Solidity + Truffle + React), FORK CHANGES

(Explanation of how the original code works can be found via [tutorial on Medium](https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a))

Forking the original repo to code various auction formats, including:

(a) Traditional Auctions: First-price, Second-price, All-pay (all sealed-bid)
(b) Batch Auctions
(c) 

Original author used ConsenSys's [truffle-webpack-demo](https://github.com/ConsenSys/truffle-webpack-demo) as a starting point, because there's quite a bit of boilerplate required between the various libraries used here.

## Running

The Web3 RPC location will be picked up from the `truffle.js` file.

0. Clone this repo
0. `npm install`
0. Make sure `testrpc` is running on its default port. Then:
  - `npm run start` - Starts the development server
  - `npm run build` - Generates a build
  - `truffle test` - Run the rest suite (there are no tests at the moment)

If you `npm run start`, the app will be available at <http://localhost:3001>.
