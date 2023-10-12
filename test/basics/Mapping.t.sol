// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract ClearableMap {
    uint256 public currentId;
    mapping(uint256 => string) map;

    function putName(string calldata name) external returns (uint256) {
        currentId++;
        map[currentId] = name;
        return currentId;
    }

    function getName(uint256 id) external view returns (string memory) {
        return map[id];
    }

    function clear() public {
        for (uint256 i = currentId; i > 0; i--) {
            delete map[i];
        }
        currentId = 0;
    }
}

contract Mapping is Test {
    struct Person {
        uint256 id;
        string name;
    }

    mapping(uint256 => string) map;
    mapping(address => Person) structMap;
    mapping(address => mapping(uint256 => string)) nestedMap;

    function test_Mapping() external {
        map[1] = "aaa";
        assertEq(map[1], "aaa");

        delete map[1];
        assertEq(map[1], "");
    }

    function test_MappingWithStruct() external {
        structMap[msg.sender] = Person(1, "aaa");
        assertEq(structMap[msg.sender].name, "aaa");

        delete structMap[msg.sender];
        assertEq(structMap[msg.sender].id, 0);
        assertEq(structMap[msg.sender].name, "");
    }

    function test_NestedMapping() external {
        nestedMap[msg.sender][1] = "aaa";
        assertEq(nestedMap[msg.sender][1], "aaa");

        //delete nestedMap[msg.sender];
        delete nestedMap[msg.sender][1];
        assertEq(nestedMap[msg.sender][1], "");
    }

    function test_ClearMapping() external {
        ClearableMap clearableMap = new ClearableMap();
        uint256 id1 = clearableMap.putName("aaa");
        uint256 id2 = clearableMap.putName("bbb");
        assertEq(clearableMap.getName(id1), "aaa");
        assertEq(clearableMap.getName(id2), "bbb");
        assertEq(clearableMap.currentId(), 2);

        clearableMap.clear();
        assertEq(clearableMap.getName(id1), "");
        assertEq(clearableMap.getName(id2), "");
        assertEq(clearableMap.currentId(), 0);
    }
}
