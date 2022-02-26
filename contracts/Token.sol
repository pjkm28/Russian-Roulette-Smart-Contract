// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Token {
    string public _name = "VarToken";
    string public _symbol = "VarT";
    uint public _totalSupply = 1411;
    uint _randNonce = 0;

    address public _owner;
    mapping(address=>uint) balance;

    constructor(){
        balance[msg.sender] = _totalSupply;
        _owner = msg.sender;        
    }

    function transfer(address _to, uint _amount) external {
        require(balance[msg.sender]>=_amount,"Not Enough Tokens");
        balance[msg.sender] -=  _amount;
        balance[_to] +=  _amount;
    }
    function CheckBalance(address _account) external view returns(uint) {
        return balance[_account];
    }
    // Roulette function between owner and player, where if probability comes more than 50% ,
    // Owner has to give bet amount to player or vice-versa.
    function RussianRoulette(address _account, uint _amount) external returns(string memory){
        _randNonce++;
        require(balance[_account]>=_amount,"Not Enough Tokens for player");
        require(balance[msg.sender]>=_amount,"Not Enough Tokens for Owner");
        uint _victory = uint(keccak256(abi.encodePacked(block.timestamp,_randNonce))) % 100;
        if (_victory >= 50) {
            balance[_account] += _amount;
            balance[msg.sender] -= _amount;
            return "Player";
        } else {
            balance[msg.sender] += _amount;
            balance[_account] -= _amount;
            return "Owner";
        }
    }
}