//SPDX-License-Identifier:GPL-3.0 

pragma solidity >= 0.7.0 < 0.9.0;

contract Ballot
{
    
    struct Voter 
    {
        bool voted;
        uint vote;
    }
    struct Proposal 
    {
        uint number;
        uint count;
        uint account; //added for crowd funding
    }
    
    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    
    // giving the input or providing the proposals' id(number) available for crowd funding
    // I have used codes instead of just numbers i.e i am categorizing based on number itself and not physical categories
    // 00 - stands for IT domain
    // 10 - stands for Agriculture domain
    // 20 - stands for HealthCare domain
    // all the proposals are still stored together in 1 struct array to save space and storage gas
    constructor (uint[] memory proposalNumbers)  {
        chairperson = msg.sender;
        for(uint i = 0; i < proposalNumbers.length; i++)
            proposals.push(Proposal({ number: proposalNumbers[i], count:0}));
    }
    
    function giveVotingRight( address voter) public view  {
       require(msg.sender == chairperson,"Only the chairperson can give the voting rights");
    }
    
    // whenever we add a number that is a proposal, it will increase the count var in the struct proposal by +1
    function vote( uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].count += 1;
        
    }
    //I created a single array then 3 variables to compare the winning count for 3 domains instead of creating 3 different arrays
    function winningProposal() public view returns (uint winningProposalForIT, uint winningProposalForAgri, uint winningProposalForHC) {
        uint winningCount_IT = 0;
        uint winningCount_Agri = 0;
        uint winningCount_HC = 0;
        
        //now we compare all proposals here and pick out the ones with maximum votes from their domain 
        for (uint p = 0 ; p < proposals.length; p++)
        {
            if (proposals[p].count > winningCount_IT && proposals[p].number < 100) {
                winningCount_IT = proposals[p].count;
                winningProposalForIT = p;
            }
            else if (proposals[p].count > winningCount_Agri && proposals[p].number < 200 && proposals[p].number > 100) {
                winningCount_Agri = proposals[p].count;
                winningProposalForAgri = p;
            }
            else if (proposals[p].count > winningCount_IT && proposals[p].number < 300 && proposals[p].number > 200 ) {
                winningCount_HC = proposals[p].count;
                winningProposalForHC = p;
            }
            else { continue; }// for any value >300
            
        }
    } 
}


abstract contract Funding is Ballot{
   
    uint public eventEnd;
    
    //address payable public investor;
    //mapping(address.balance => uint) investors_balance;
    //mapping(address => balance) investors_balance;
    //mapping(address => uint) investors;
    uint money_donated =0;
    bool ended;
    uint target;

    event fundingIncreased(address investors, uint amt);
    event eEnded( uint win, uint amt);

   // will give when the funding will end and who will donate
    constructor ( uint _fundTime, uint[] memory target_) {
        eventEnd = block.timestamp + _fundTime;
        target = target_;
    }
    
   
    function donate_(uint money_donated_, uint proposal_select, address payable investor_) public payable returns (bool)  {
       money_donated = money_donated_; 
       //investor =  investor_;
       require(block.timestamp <= eventEnd, "Crowd Funding has already ended.");
       if (target > target + money_donated)
       { 
           emit fundingIncreased(" Target achieved for the Proposal. ");
           
       }
       if (money_donated != 0)
       {
            msg.sender.transfer(money_donated);
            proposals.number.account += money_donated;
            investor_ -= money_donated;
       }
        emit fundingIncreased(msg.sender, msg.value);
    }
    

    function withdraw() public returns (bool) {
        uint amount = investor[msg.sender];
        if (amount > 0) {
            investor[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                investor[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function EventEnd() public {
        
        require(block.timestamp >= eventEnd, "Auction not yet ended.");
        require(!ended, "auctionEnd has already been called.");

        ended = true;
        emit eEnded(winningProposal, money_donated);
        
    }

}
