// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

error raffle_not_enough_eth();

contract raffle is VRFConsumerBaseV2{

    uint256 private immutable i_entrancefee;
    address payable[] private s_players;
    //VRFConsumerBaseV2 private coordinator;
    event raffleenter(address); // name is reverse of function name


    constructor(address vrfcoordinator, uint256 entrancefee ) VRFConsumerBaseV2(vrfcoordinator){
        
        //coordinator = VRFCoordinatorV2Interface(vrfcoordinator);
        i_entrancefee=entrancefee;

    }

    function enterraffle() public payable{

        //require use extra gas
        if(msg.value<i_entrancefee){revert raffle_not_enough_eth();}
        s_players.push(payable(msg.sender));

         //emit an event on adding a player
        emit raffleenter(msg.sender);

    }
    
    function request_random_winner() external {


    }

    function fulfillRandomWords(uint256,uint256[] memory randomwords) internal override{



    }
    function get_entrancefee() public view returns(uint256){

        return i_entrancefee;

    }

    function get_players(uint256 index) public view returns(address){

        return s_players[index];

    }
}