// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract Modifier {
    address private _owner;
    uint256 private _value;

    error UnauthorizedAccount(address account);

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        if (_owner != msg.sender) {
            revert UnauthorizedAccount(msg.sender);
        }
        _;
    }

    modifier checkValue(uint256 value_) virtual {
        require(value_ > 0, "The value must be greater than 0");
        _;
    }

    function changeValue(uint256 value_) public onlyOwner checkValue(value_) returns (uint256) {
        _value = value_;
        return value_;
    }
}

contract ModifierChild is Modifier {
    modifier checkValue(uint256 value_) override {
        require(value_ > 1 ether, "The value must be greater than 1 ether");
        _;
    }
}

contract ModifierTest is Test {
    function test_OnlyOwner() external {
        Modifier m = new Modifier();
        assertEq(m.changeValue(1), 1);
    }

    function testFuzz_OnlyOwner_RevertIf_SenderIsNotOwner(address sender_) external {
        vm.assume(sender_ != address(this));

        Modifier m = new Modifier();

        vm.prank(sender_);
        vm.expectRevert(abi.encodeWithSelector(Modifier.UnauthorizedAccount.selector, sender_));
        m.changeValue(1);
    }

    function test_OverrideModifier() external {
        Modifier m = new ModifierChild();
        assertEq(m.changeValue(2 ether), 2 ether);

        vm.expectRevert("The value must be greater than 1 ether");
        m.changeValue(1 ether);
    }
}
