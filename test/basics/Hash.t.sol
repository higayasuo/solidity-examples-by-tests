// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract MyContract {}

contract HashTest is Test {
    struct Aaa {
        string name;
    }

    function test_Keccak256() external {
        console.log("keccak256 string");
        console.logBytes32(keccak256(abi.encode("aaa")));

        console.log("keccak256 uint");
        console.logBytes32(keccak256(abi.encode(123)));

        console.log("keccak256 bool");
        console.logBytes32(keccak256(abi.encode(true)));

        console.log("keccak256 struct");
        console.logBytes32(keccak256(abi.encode(Aaa("aaa"))));

        console.log("keccak256 contract");
        console.logBytes32(keccak256(abi.encodePacked(new MyContract())));

        console.log("keccak256 encodePacked concat(aaa, bbb)");
        console.logBytes32(keccak256(abi.encodePacked("aaa", "bbb")));

        console.log("keccak256 encodePacked concat(aa, abbb)");
        console.logBytes32(keccak256(abi.encodePacked("aa", "abbb")));

        console.log("keccak256 encode concat(aaa, bbb)");
        console.logBytes32(keccak256(abi.encode("aaa", "bbb")));

        console.log("keccak256 encode concat(aa, abbb)");
        console.logBytes32(keccak256(abi.encode("aa", "abbb")));
    }

    function test_Sha256() external view {
        console.log("sha256 string");
        console.logBytes32(sha256(abi.encode("aaa")));
    }

    function test_Ripemd160() external view {
        console.log("ripemd160 string");
        console.logBytes32(ripemd160(abi.encode("aaa")));
    }
}
