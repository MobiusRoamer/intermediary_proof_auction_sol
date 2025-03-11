# Intermediary-Proof Auction Mechanisms
Forked a benchmark model to build an intermediary-proof auction mechanism, the benchmark model can be found in "contracts" > "Basic Auction.sol"
(Explanation of how the original code works can be found via [tutorial on Medium](https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a))

The theoretical model comes from the paper "Maximizing Revenue in the Presence of Intermediaries" by Aggarwal.G, Bhawalkar, K. Guruganesh, G. and Perlroth, A.2022.

### TL;DR:Original Paper
The paper considers a mechanism design problem of selling $k$ items to $n$ unit-demand buyers with private valuations for the items. Divide the number of buyers (aggregate demand) by the number of items, and take their ceiling function integer value $s$, which means we have $s$ groups of buyers, then the intermediary-proof mechanism is a uniform single-item pricing scheme where each item is sold separately at a price set equal to the highest expected buyer valuation within each of the $s$ groups. The mechanism of course assumes a commonly known valuation distribution prior. 

### TL;DR:Extension
On blockchain, the number of users are not generally known. For example, the number of liquidity stakers in a liquidity staking pool is a piece of information managed by the intermediary service provider, hence unavailable on-chain. We thereby make the mechansim independent of the number of users, but instead dependent on the value of tx submitted by the intermediary on behalf of the users, which is usually publicly available on the blockchain ledger. 

### Definitions
Transaction (tx) Demand Structure / Intermediary Representation of Heterogeneous Users: Users demand heterogeneous blockspace units, we take their aggregate tx values to be $V$. The demand structure $(m,\pi)$ of a single-slot market with aggregate tx value $V$ is composed of $m$ intermediaries and a partition $\pi(\cdot)$ of $V$. For an intermediary $l\in [m]$ we let $\pi(l)$ denote the value of tx that intermediary $l$ represents. These intermediaries are in general service providers such as sequencers, aggregators, builders, etc. The value $\pi(l)$ can be interpreted as the total amount of MEV income extracted by the intermediary.

$s=

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
