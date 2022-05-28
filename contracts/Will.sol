// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Will {
    address owner;
    uint256 fortune;
    bool deceased;

    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier mustDeceased() {
        require(deceased == true);
        _;
    }

    address payable[] familyWallets;

    mapping(address => uint256) inheritance;

    function setInheritance(address payable wallet, uint256 amount)
        public
        onlyOwner
    {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    function payout() private mustDeceased {
        for (uint256 i = 0; i < familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}
