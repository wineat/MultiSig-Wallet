pragma solidity 0.7.5;
pragma abicoder v2;

import "./Ownable.sol";
//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"]
contract Wallet {
    
    address[] owners;
    uint limit;
    
    struct Transfer {
        uint id;
        uint noOfApprovals;
        address from;
        address payable to;
        uint amount;
        bool isApproved;
    }
    
    Transfer[] transferRequests;
    
    mapping(address => uint) balance;
    
    constructor(uint _limit, address[] memory _owners) {
        require(_limit >= 2, "Two or more approvers required");
        require(_owners.length >= _limit, "Limit exceeds the number of approvers");
         bool _duplicate;
        for(uint i=0; i<_owners.length; i++) {
            for(uint j= i+1; j< _owners.length; j++) {
                if(_owners[i] == _owners[j]) {
                    _duplicate = true;
                    break;
                }
            }
            if(_duplicate == false) {
                owners.push(_owners[i]);
            }
        }
        require(_duplicate == false, "Duplicate Signatory");
        limit = _limit;
    }
    
    function deposit() payable public returns(uint) {
        balance[msg.sender] += msg.value;
        return balance[msg.sender];
    }
    
    function getBalance() public returns(uint) {
        return balance[msg.sender];
    }
}
