// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test4 {
/*
간단한 게임이 있습니다.
유저는 번호, 이름, 주소, 잔고, 점수를 포함한 구조체입니다. 
참가할 때 참가비용 0.01ETH를 내야합니다. (payable 함수)
4명까지만 들어올 수 있는 방이 있습니다. (array)
선착순 4명에게는 각각 4,3,2,1점의 점수를 부여하고 4명이 되는 순간 방이 비워져야 합니다.

예) 
방 안 : "empty" 
-- A 입장 --
방 안 : A 
-- B, D 입장 --
방 안 : A , B , D 
-- F 입장 --
방 안 : A , B , D , F 
A : 4점, B : 3점 , D : 2점 , F : 1점 부여 후 
방 안 : "empty" 

유저는 10점 단위로 점수를 0.1ETH만큼 변환시킬 수 있습니다.
예) A : 12점 => A : 2점, 0.1ETH 수령 // B : 9점 => 1점 더 필요 // C : 25점 => 5점, 0.2ETH 수령

* 유저 등록 기능 - 유저는 이름만 등록, 번호는 자동적으로 순차 증가, 주소도 자동으로 설정, 점수도 0으로 시작
* 유저 조회 기능 - 유저의 전체정보 번호, 이름, 주소, 점수를 반환. 
* 게임 참가시 참가비 제출 기능 - 참가시 0.01eth 지불 (돈은 smart contract가 보관)
* 점수를 돈으로 바꾸는 기능 - 10점마다 0.1eth로 환전
* 관리자 인출 기능 - 관리자는 0번지갑으로 배포와 동시에 설정해주세요, 관리자는 원할 때 전액 혹은 일부 금액을 인출할 수 있음 (따로 구현)
---------------------------------------------------------------------------------------------------
* 예치 기능 - 게임할 때마다 참가비를 내지 말고 유저가 일정금액을 미리 예치하고 게임할 때마다 자동으로 차감시키는 기능.
*/

struct User {
        uint id;
        string name;
        address userAddress;
        uint score;
        uint balance;
    }

    address  owner;
    uint  userCount;
    uint  ENTRY_FEE = 0.01 ether;
    uint  SCORE_TO_ETH_RATE = 10;
    uint  ETH_REWARD = 0.1 ether;

    mapping(address => User) users;
    address[4] currentRoom;
    uint roomCount;

    constructor() {
        owner = address(0);
    }

    function registerUser(string memory _name) external {
        userCount++;
        users[msg.sender] = User(userCount, _name, msg.sender, 0, 0);
    }

    function getUserInfo(address _userAddress) external view returns (User memory) {
        return users[_userAddress];
    }

    function enterGame() external payable {
        
        if (users[msg.sender].balance >= ENTRY_FEE) {
            users[msg.sender].balance -= ENTRY_FEE;
        } else {
            users[msg.sender].balance += msg.value - ENTRY_FEE;
        }

        currentRoom[roomCount] = msg.sender;
        roomCount++;

        if (roomCount == 4) {
            for (uint i = 0; i < 4; i++) {
                users[currentRoom[i]].score += 4 - i;
            }
            delete currentRoom;
            roomCount = 0;
        }
    }

    function exchangeScore() external {
        User storage user = users[msg.sender];
        uint exchangeableScore = user.score - (user.score % SCORE_TO_ETH_RATE);
        uint ethAmount = (exchangeableScore / SCORE_TO_ETH_RATE) * ETH_REWARD;
        user.score -= exchangeableScore;
        payable(msg.sender).transfer(ethAmount);
    }

    function deposit() external payable {
        users[msg.sender].balance += msg.value;
    }

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Only owner");
        require(_amount <= address(this).balance, "Not enough balance");
        payable(owner).transfer(_amount);
    }
}










