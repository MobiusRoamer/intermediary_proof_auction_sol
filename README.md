# Intermediary-Proof Auction Mechanisms
Forked a benchmark model to build an intermediary-proof auction mechanism, the benchmark model can be found in "contracts" > "Basic Auction.sol"
(Explanation of how the original code works can be found via [tutorial on Medium](https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a))

The theoretical model comes from the paper "Maximizing Revenue in the Presence of Intermediaries" by Aggarwal.G, Bhawalkar, K. Guruganesh, G. and Perlroth, A.2022.

### TL;DR: 
The paper considers a mechanism design problem of selling $k$ items to $n$ unit-demand buyers with private valuations for the items. Divide the number of buyers (aggregate demand) by the number of items, and take their ceiling function integer value $s$, which means we have $s$ groups of buyers, then the intermediary-proof mechanism is a uniform single-item pricing scheme where each item is sold separately at a price set equal to the highest expected buyer valuation within each of the $s$ groups. The mechanism of course assumes a commonly known valuation distribution prior. 

### Definitions
Transaction (tx) Demand Structure / Intermediary Representation of Users: We begin with a simple case where each user demands only a unit blockspace. The demand structure $(m,\pi)$ of a market with $n$ users is composed of, without any loss of generality, $m\leq n$ intermediaries and a partition $\pi(\cdot)$ of the set of users. For an intermediary $l\in [m]$ we let $\pi(l)$ denote the set of users that intermediary $l$ represents. These intermediaries are in general service providers such as sequencers, aggregators, builders, etc. 



### Technical Notes
Original author used ConsenSys's [truffle-webpack-demo](https://github.com/ConsenSys/truffle-webpack-demo) as a starting point, because there's quite a bit of boilerplate required between the various libraries used here.

### Running

The Web3 RPC location will be picked up from the `truffle.js` file.

0. Clone this repo
0. `npm install`
0. Make sure `testrpc` is running on its default port. Then:
  - `npm run start` - Starts the development server
  - `npm run build` - Generates a build
  - `truffle test` - Run the rest suite (there are no tests at the moment)

If you `npm run start`, the app will be available at <http://localhost:3001>.
