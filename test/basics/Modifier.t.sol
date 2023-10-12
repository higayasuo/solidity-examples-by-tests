// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

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

    modifier checkValue(uint256 value_) {
        require(value_ > 0, "The value must be greater than 0");
        _;
    }

    function chageValue(uint256 value_) public onlyOwner checkValue(value_) returns (uint256) {
        _value = value_;
        return value_;
    }
}

contract ModifierTest is Test {
    function test_OnlyOwner() external {
        Modifier m = new Modifier();
        assertEq(m.chageValue(1), 1);
    }

    function testFuzz_OnlyOwner_RevertIf_SenderIsNotOwner(address sender_) external {
        vm.assume(sender_ != address(this));

        Modifier m = new Modifier();

        vm.prank(sender_);
        vm.expectRevert(abi.encodeWithSelector(Modifier.UnauthorizedAccount.selector, sender_));
        m.chageValue(1);
    }
}
