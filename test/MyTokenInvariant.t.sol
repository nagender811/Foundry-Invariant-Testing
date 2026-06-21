// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {MyHandler} from "./MyTokenHandler.t.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract MyTokenInvariantTest is StdInvariant, Test {
    MyToken token;
    MyHandler handler;

    function setUp() public {
        token = new MyToken();
        token.mintMyToken(1000);
        
        handler = new MyHandler(token);

        vm.prank(address(token));
        token.transfer(address(handler), 1000);

        bytes4[] memory selectors = new bytes4[](1);

        selectors[0] = MyHandler.transferTokens.selector;
        targetContract(address(handler));
        targetSelector(FuzzSelector({addr:address(handler),selectors:selectors}));
    }

    function invariant_totalSupplyShouldBe1000() public view {
        assertEq(token.totalSupply(), 1000);
    }
}
