// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {MyHandler} from "./MyTokenHandler.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract MyTokenInvariantTest is StdInvariant, Test {
    MyToken token;
    MyHandler handler;

    function setUp() public {
        token = new MyToken();
        token.mintMyToken(1000);
        handler = new Myhandler(token);
        token.transfer(address(handler), 1000);

        bytes4[] selectors = new bytes()[1];

        selectors[0] = MyHandler.transferTokens.selectors;
        targetSelector(FuzzSelector({addr:address(handler),selectors.selectors}));
        targetContract(address(handler));
    }

    function invariant_totalSupplyShouldBeZeroWhenNoMinting() public view {
        assertEq(token.totalSupply(), 0);
    }
}
