// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract StructTest is Test {
    struct Person {
        uint256 id;
        string name;
    }

    struct StructWithArray {
        uint256 id;
        string[] names;
    }

    struct StructWithMapping {
        uint256 id;
        mapping(uint256 => string) map;
    }

    Person private person;
    Person[] private people;

    StructWithArray private structWithArray;
    StructWithMapping private structWithMapping;

    function test_Struct() external {
        person = Person(1, "aaa");
        assertEq(person.id, 1);
        assertEq(person.name, "aaa");

        Person memory person2 = Person({id: 2, name: "bbb"});
        assertEq(person2.id, 2);
        assertEq(person2.name, "bbb");

        person2 = person;
        assertEq(person2.id, 1);
        assertEq(person2.name, "aaa");

        person2.name = "ccc";
        assertEq(person2.name, "ccc");
        assertEq(person.name, "aaa");

        //Person storage person3 = Person(3, "ccc");
        Person storage person3 = person;
        person3.name = "ccc";
        assertEq(person3.name, "ccc");
        assertEq(person.name, "ccc");
    }

    function test_structArray() external {
        //people.length = 0;
        delete people;
        assertEq(people.length, 0);

        people.push(Person({id: 1, name: "aaa"}));
        assertEq(people.length, 1);
        assertEq(people[0].id, 1);
        assertEq(people[0].name, "aaa");
    }

    function test_StructWithArray() external {
        string[] memory names = new string[](1);
        names[0] = "aaa";
        structWithArray = StructWithArray(1, names);
        assertEq(structWithArray.id, 1);
        assertEq(structWithArray.names.length, 1);
        assertEq(structWithArray.names[0], "aaa");

        structWithArray.names.push("bbb");
        assertEq(structWithArray.names.length, 2);
        assertEq(structWithArray.names[1], "bbb");

        //StructWithArray memory structWithArray2 = StructWithArray({id: 2});
        StructWithArray memory structWithArray2 = StructWithArray({id: 2, names: new string[](0)});
        assertEq(structWithArray2.names.length, 0);
    }

    function test_StructWithMapping() external {
        structWithMapping.id = 1;
        structWithMapping.map[1] = "aaa";
        assertEq(structWithMapping.id, 1);
        assertEq(structWithMapping.map[1], "aaa");
    }
}
