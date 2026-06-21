// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyHandler is Test {
    MyToken public token;
    address to = makeAddr("to");
    

   constructor(MyToken _token) {
    token = _token;
   }

   function mintTokens(uint256 amount) public {
       token.mintMyToken(amount);
   }

   function transferTokens(uint256 amount) public {
    amount = bound(amount, 0, token.balanceOf(address(this)));
    token.transfer(to, amount);
   }
}