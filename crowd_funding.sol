pragma solidity ^0.4.22;
import "./voting_proposal.sol";
contract crowd_funding is Ballot
{
    address public owner;
    string name; 
    uint256 goal;
    uint public totalRaised;
    uint public remaining_amount;
    mapping(address => uint256) public donation;
    
    constructor(uint target)public{
        owner=msg.sender;
        goal=target;
        totalRaised=0;
        remaining_amount=goal;
    }

    
   function donate(uint256 amount) public payable {
        require(msg.value == amount);
        if(amount<msg.sender.balance){
            address(owner).transfer(msg.value);
            totalRaised+=amount;
            remaining_amount=goal-totalRaised;
            
            
    }}

    function fund_transfer() public payable {
        require(msg.sender == owner);
        require(msg.sender.balance >= goal && remaining_amount==0); // funding goal met
        address(winner_address).transfer(msg.value);
    }

    
}