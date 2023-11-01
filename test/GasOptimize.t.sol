// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../lib/ERC721A/contracts/ERC721A.sol";

contract CounterTest is Test {
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    MyERC721A public erc721a;
    MyERCEnumerable public erc721Enumerable;

    function setUp() public {
        erc721a = new MyERC721A();
        erc721Enumerable = new MyERCEnumerable();
    }

    function test_MyERC721AMint() public {
        vm.startPrank(user1);
        erc721a.mint(user1, 1);
        vm.stopPrank();

        assertEq(erc721a.balanceOf(user1), 1);
        assertEq(erc721a.totalSupply(), 1);
    }

    function test_MyERC721AMint5() public {
        vm.startPrank(user1);
        erc721a.mint5(user1);
        vm.stopPrank();

        assertEq(erc721a.balanceOf(user1), 5);
        assertEq(erc721a.totalSupply(), 5);
    }

    function test_MyERC721ATransfer() public {
        vm.startPrank(user1);
        erc721a.mint(user1, 1);
        erc721a.transferFrom(user1, user2, 0);
        vm.stopPrank();

        assertEq(erc721a.balanceOf(user2), 1);
    }

    function test_MyERC721AApprove() public {
        vm.startPrank(user1);
        erc721a.mint(user1, 1);
        erc721a.approve(user2, 0);
        vm.stopPrank();

        vm.startPrank(user2);
        erc721a.transferFrom(user1, user2, 0);
        vm.stopPrank();

        assertEq(erc721a.balanceOf(user1), 0);
        assertEq(erc721a.balanceOf(user2), 1);
    }

    function test_MyERCEnumerableMint() public {
        vm.startPrank(user1);
        erc721Enumerable.mint(user1);
        vm.stopPrank();

        assertEq(erc721Enumerable.balanceOf(user1), 1);
        assertEq(erc721Enumerable.totalSupply(), 1);
    }

    function test_MyERCEnumerableMint5() public {
        vm.startPrank(user1);
        erc721Enumerable.mint5(user1);
        vm.stopPrank();
        
        assertEq(erc721Enumerable.balanceOf(user1), 5);
        assertEq(erc721Enumerable.totalSupply(), 5);
    }

    function test_MyERCEnumerableTransfer() public {
        vm.startPrank(user1);
        erc721Enumerable.mint(user1);
        erc721Enumerable.transferFrom(user1, user2, 0);
        vm.stopPrank();
   
        assertEq(erc721Enumerable.balanceOf(user2), 1);
    }

    function test_MyERCEnumerableApprove() public {
        vm.startPrank(user1);
        erc721Enumerable.mint(user1);
        erc721Enumerable.approve(user2, 0);
        vm.stopPrank();

        vm.startPrank(user2);
        erc721Enumerable.transferFrom(user1, user2, 0);
        vm.stopPrank();

        assertEq(erc721Enumerable.balanceOf(user1), 0);
        assertEq(erc721Enumerable.balanceOf(user2), 1);
    }
}


contract MyERC721A is ERC721A {
    
    constructor() ERC721A("ERC721A", "721A") {}

    function mint(address _to, uint256 _quantity) external payable {
        _mint(_to, _quantity);
    }

    function mint5(address _to) external payable {
        _mint(_to, 5);
    }
}

contract MyERCEnumerable is ERC721Enumerable {
    constructor() ERC721("ERC721Eum", "721Enum") {}

    function mint(address _to) public payable {
        _mint(_to, totalSupply());
    }

    function mint5(address _to) external payable {
        uint256 quantity = 5;
        do {
            _mint(_to, totalSupply());
            quantity = quantity -1;
        } while (quantity > 0);
    }
}