// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test10{
/*
로또 프로그램을 만드려고 합니다. 
숫자와 문자는 각각 4개 2개를 뽑습니다. 6개가 맞으면 1이더, 5개의 맞으면 0.75이더, 
4개가 맞으면 0.25이더, 3개가 맞으면 0.1이더 2개 이하는 상금이 없습니다. 

참가 금액은 0.05이더이다.

예시 1 : 8,2,4,7,D,A
예시 2 : 9,1,4,2,F,B
*/
    address public owner;
    uint public constant TICKET_PRICE = 0.05 ether;
    uint8[4] public winningNumbers;
    bytes1[2] public winningCharacters;
    mapping(address => uint8[4]) private ticketNumbers;
    mapping(address => bytes1[2]) private ticketCharacters;

    event TicketBought(address buyer);
    event PrizePaid(address winner, uint amount);

    constructor() payable {
        owner = msg.sender;
    }

    function buyTicket(uint8[4] memory _numbers, bytes1[2] memory _characters) public {
        require(address(this).balance >= TICKET_PRICE, "Contract doesn't have enough balance");
        ticketNumbers[msg.sender] = _numbers;
        ticketCharacters[msg.sender] = _characters;
        emit TicketBought(msg.sender);
    }

    function drawLottery(uint8[4] memory _winningNumbers, bytes1[2] memory _winningCharacters) public {
        require(msg.sender == owner, "Only owner can draw lottery");
        winningNumbers = _winningNumbers;
        winningCharacters = _winningCharacters;
        
        uint matches = checkMatches(msg.sender);
        uint prize;
        
        if (matches == 6) prize = 1 ether;
        else if (matches == 5) prize = 0.75 ether;
        else if (matches == 4) prize = 0.25 ether;
        else if (matches == 3) prize = 0.1 ether;

        if (prize > 0) {
            require(address(this).balance >= prize, "Contract doesn't have enough balance for prize");
            payable(msg.sender).transfer(prize);
            emit PrizePaid(msg.sender, prize);
        }
    }

    function checkMatches(address player) public view returns (uint) {
        uint matches = 0;
        for (uint i = 0; i < 4; i++) {
            if (ticketNumbers[player][i] == winningNumbers[i]) matches++;
        }
        for (uint i = 0; i < 2; i++) {
            if (ticketCharacters[player][i] == winningCharacters[i]) matches++;
        }
        return matches;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}