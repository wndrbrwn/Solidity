// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test10{
/*
주차정산 프로그램을 만드세요. 주차시간 첫 2시간은 무료, 그 이후는 1분마다 200원(wei)씩 부과합니다. 
주차료는 차량번호인식을 기반으로 실행됩니다.
주차료는 주차장 이용을 종료할 때 부과됩니다.
----------------------------------------------------------------------
차량번호가 숫자로만 이루어진 차량은 20% 할인해주세요.
차량번호가 문자로만 이루어진 차량은 50% 할인해주세요.
*/
 struct Car {
        uint time;
        bool In;
    }

    mapping(string => Car) public cars;
    uint constant FREE = 2 hours;
    uint constant RATE = 200 wei;

    function park(string memory plate) public {
        require(!cars[plate].In, "Already parked");
        cars[plate] = Car(block.timestamp, true);
    }

    function exit(string memory plate) public payable {
        require(cars[plate].In, "Not parked");
        uint fee = getFee(plate);
        require(msg.value >= fee, "Not enough");

        delete cars[plate];

        if (msg.value > fee) {
            payable(msg.sender).transfer(msg.value - fee);
        }
    }

    function getFee(string memory plate) public view returns (uint) {
        uint time = block.timestamp - cars[plate].time;
        if (time <= FREE) return 0;

        uint fee = ((time - FREE) / 1 minutes) * RATE;

        if (isNum(plate)) return fee * 80 / 100;
        if (isAlpha(plate)) return fee / 2;
        return fee;
    }

    function isNum(string memory s) internal pure returns (bool) {
        bytes memory b = bytes(s);
        for (uint i; i < b.length; i++) {
            if (b[i] < 0x30 || b[i] > 0x39) return false;
        }
        return true;
    }

    function isAlpha(string memory s) internal pure returns (bool) {
        bytes memory b = bytes(s);
        for (uint i; i < b.length; i++) {
            if ((b[i] < 0x41 || b[i] > 0x5A) && (b[i] < 0x61 || b[i] > 0x7A)) return false;
        }
        return true;
    }
}