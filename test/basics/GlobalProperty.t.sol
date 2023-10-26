// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract A {
    B b = new B();

    function getSenders() external view returns (address, address) {
        return b.getSenders();
    }
}

contract B {
    function getSenders() external view returns (address, address) {
        return (msg.sender, tx.origin);
    }
}

contract GlobalPropertyTest is Test {
    function test_Properties() external payable {
        console.log("block number:", block.number);
        console.log("blockhash:");
        console.logBytes32(blockhash(block.number));
        console.log("block basefee:", block.basefee);
        console.log("block chainid:", block.chainid);
        console.log("block coinbase:", block.coinbase);
        console.log("block gaslimit:", block.gaslimit);
        console.log("block prevrandao:", block.prevrandao);
        console.log("block timestamp:", block.timestamp);
        console.log("block gasleft:", gasleft());
        console.log("block gasleft:", tx.gasprice);
        console.log("blockhash:");
        console.logBytes(msg.data);
        assertEq(msg.data, abi.encodeWithSignature(("test_Properties()")));
        console.log("msg.sender:", msg.sender);
        console.log("msg.sig:");
        console.logBytes4(msg.sig);
        assertEq(msg.sig, GlobalPropertyTest.test_Properties.selector);
        console.log("msg.value:", msg.value);
        console.log("tx.gasprice:", tx.gasprice);
        console.log("tx.origin:", tx.origin);

        A a = new A();
        (address sender, address origin) = a.getSenders();
        console.log("this:", address(this));
        console.log("a:", address(a));
        console.log("sender:", sender);
        console.log("origin:", origin);
    }
}
