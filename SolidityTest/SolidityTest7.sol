// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;


contract Test7{
/*
* 악셀 기능 - 속도를 10 올리는 기능, 악셀 기능을 이용할 때마다 연료가 20씩 줄어듬, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 속도가 70이상이면 악셀 기능은 더이상 못씀
* 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨
* 브레이크 기능 - 속도를 10 줄이는 기능, 브레이크 기능을 이용할 때마다 연료가 10씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
* 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
* 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
--------------------------------------------------------
* 충전식 기능 - 지불을 미리 해놓고 추후에 주유시 충전금액 차감 
*/
address public owner;
    uint public speed;
    uint public fuel;
    bool public isOn;
    uint public balance;

    constructor() {
        owner = msg.sender;
        speed = 0;
        fuel = 100;
        isOn = false;
        balance = 0;
    }

    function accelerate() public {
        require(isOn, "The car is not turned on");
        require(speed < 70, "Speed limit");
        require(fuel > 30, "Not enough fuel");
        
        speed += 10;
        fuel -= 20;
    }

    function refuel() public {
        require(fuel < 100, "Fuel tank is already full");
        require(balance >= 1 ether, "Insufficient balance for refueling");
        
        balance -= 1 ether;
        fuel = 100;
    }

    function brake() public {
        require(isOn, "The car is not turned on");
        require(speed > 0, "already stopped");
        
        speed -= 10;
        if (speed < 0) speed = 0;
        fuel -= 10;
    }

    function turnOff() public {
        require(isOn, "The car is already turned off");
        require(speed == 0, "Cannot turn off while moving");
        
        isOn = false;
    }

    function turnOn() public {
        require(!isOn, "The car is already turned on");
        
        isOn = true;
        speed = 0;
    }

    function charge() public payable {
        balance += msg.value;
    }

    function getBalance() public view returns (uint) {
        return balance;
    }

    function withdraw() public {
        require(balance > 0, "No balance to withdraw");
        payable(owner).transfer(balance);
        balance = 0;
    }
}