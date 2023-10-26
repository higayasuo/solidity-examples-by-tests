// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract Address {
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    function getBalance() external view returns (uint256) {
        return _owner.balance;
    }

    function getCode() external view returns (bytes memory) {
        return address(this).code;
    }

    function getCodehash() external view returns (bytes32) {
        return address(this).codehash;
    }

    function transfer(address payable to) external payable {
        to.transfer(msg.value);
    }

    function send(address payable to) external payable {
        bool success = to.send(msg.value);
        require(success, "Failed");
    }

    function call(address payable to) external payable {
        (bool success,) = to.call{value: msg.value}("");
        require(success, "Failed");
    }
}

contract To {
    receive() external payable {}
}

contract AddressTest is Test {
    Address private _target;

    function setUp() external {
        _target = new Address();
    }

    function test_GetBalance() external view {
        console2.log("balance:", _target.getBalance());
    }

    function test_GetCode() external view {
        console2.log("the length of the code:", _target.getCode().length);
    }

    function test_GetCodehash() external view {
        console2.log("the length of the codehash:", _target.getCodehash().length);
    }

    function test_Transfer() external {
        To to = new To();
        uint256 preBalance = address(to).balance;
        assertEq(preBalance, 0);

        _target.transfer{value: 1 ether}(payable(address(to)));
        uint256 postBalance = address(to).balance;
        assertEq(postBalance, 1 ether);
    }

    function test_Send() external {
        To to = new To();
        uint256 preBalance = address(to).balance;
        assertEq(preBalance, 0);

        _target.send{value: 1 ether}(payable(address(to)));
        uint256 postBalance = address(to).balance;
        assertEq(postBalance, 1 ether);
    }

    function test_Call() external {
        To to = new To();
        uint256 preBalance = address(to).balance;
        assertEq(preBalance, 0);

        _target.call{value: 1 ether}(payable(address(to)));
        uint256 postBalance = address(to).balance;
        assertEq(postBalance, 1 ether);
    }
}
