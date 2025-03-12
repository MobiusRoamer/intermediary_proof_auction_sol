pragma solidity >=0.7.0 < 0.9.0;
//Bidders = intermediaries bidding on behalf of users
contract inter_proof_auction {
    
    address public owner;
    uint public bidIncrement;
    uint public startBlock;
    uint public endBlock;

    //Intermediaries act on behalf of the "auctioneer" (group of validators)
    uint public numBidders;

    bool public auctionEnded;
    bool public canceled;
    
    //Bidder strategy: bidder i submits bi
    struct Bid{
        address bidder;
        uint bi;
    }

    //Create bids matrix array
    Bid[] public bids; //We populate the bids variables in the laterPlacebid function
    mapping(address=> uint) public fundsByBidder;
    mapping(uint => uint) public AvgPrice; //The average price of the txs available to the validators

    //Log critical events
    event LogBid(address indexed bidder, uint amount);
    event LogAuctionEnded();
    event LogPostedprice(uint GroupID, uint price);
    
    //Restrictions
    //Only owner can call the executePricing function, the owner can be any attester 
    //who deploys the smart contract first
    modifier onlyOwner{
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyBeforeEnd{
        require(block.number <= endBlock, "Auction has ended");
        _;
    }

    //Initialize the auction mechanism, store input parameters into state variables
    constructor(uint _startBid, uint _endBid, uint _numBidders){  //Fix version problem
        require(_startBlock < _endBlock, "Invalid Auction Period");
        owner = msg.sender;
        startBlock = _startBlock;
        endBlock = _endBlock;
        numBidders = _numBidders;
    }

    //Now we build the bids array to prepare for sorting
    function placeBid() external payable onlyBeforeEnd {
        require(msg.value >0, "Bid must be greater than 0");

        bids.push(Bid({bidder:msg.sender, amount: msg.value}));
        fundsByBidder[msg.sender] += msg.value;
        emit LogBid(msg.sender, msg.value);
    }

    function executePricing() external onlyOwner {
        require(block.number > endBlock, "Auction has not ended yet");
        require(!auctionEnded, "Auction already ended");
        // require(bids.length >= numBidders, "Not enough bids to distribute");

        //Sort bids
        for (uint i = 0; i < bids.length; i++){
            if (bids[j].amount > bids[i].amount){
                Bid memory temp = bids[i];
                bids [i]=bids[j];
                bids[j]=temp;
            }
        }
    }
    //Initialze two arrays to prepare for partitions
    uint[] memory bidSums = new uint[](numBidders);
    uint[] memory bidCounts = new uint[](numBidders);
    //we will ultimately allocate all bids to "persons", the attesters to peform the validation
    //Iteratively pick the least busy person as they submit txs, we keep increasing the workload of the least busy person
    for (uint i = 0; i < bids.length; i++){
        uint minBid = 0;
        for (uint j = 1; j<numBidders; j++){
            if (bidSums [j] / (bidCounts[i]+1) < bidSums[minBid]/(bidCounts[minBid]+1) ){
                minBid = j;
            }
        }
        //increment the workload assigned to the least busy person
        bidSums[minBid] += bids[i].amount;
        //increment the number of bids handled by the least busy person
        bidCounts[minBid]++;
    }
    //Posted Prices
    for (uint i = 0; i <numBidders; i++){
        AvgPrice[i] = bidSums[i]/bidCounts[i];
        emit LogPostedPrice(i,AvgPrice[i]);
    }

    auctionEnded = true;
    emit LogAuctionEnded();
    }

    function claimGroup(uint GroupID) external {
        require(auctionEnded, "Auction not ended yet");
        require(AvgPrice[GroupID]>0, "Group does not exist");

        //How show the validators claim the batch at the posted price?
    }
