// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q51 {
/*숫자들이 들어가는 배열을 선언하고 그 중에서 3번째로 큰 수를 반환하세요.
*/
    function thirdLargest(uint[] memory numbers) public pure returns (uint) {
        require(numbers.length >= 3, "Array should have at least 3 elements");
        uint first = 0;
        uint second = 0;
        uint third = 0;
        
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] > first) {
                third = second;
                second = first;
                first = numbers[i];
            } else if (numbers[i] > second && numbers[i] != first) {
                third = second;
                second = numbers[i];
            } else if (numbers[i] > third && numbers[i] != second && numbers[i] != first) {
                third = numbers[i];
            }
        }
        return third;
    }
}

contract Q52 {
/*자동으로 아이디를 만들어주는 함수를 구현하세요. 

  이름, 생일, 지갑주소를 기반으로 만든 해시값의 첫 10바이트를 추출하여 아이디로 만드시오.
*/
    function generateId(string memory name, uint birthday, address wallet) public pure returns (bytes10) {
        return bytes10(keccak256(abi.encodePacked(name, birthday, wallet)));
    }
}

contract Q53 {
/*1. 시중에는 A,B,C,D,E 5개의 은행이 있습니다. 각 은행에 고객들은 마음대로 입금하고 인출할 수 있습니다. 
    
    각 은행에 예치된 금액 확인, 입금과 인출할 수 있는 기능을 구현하세요.
    
    힌트 : 이중 mapping을 꼭 이용하세요.
*/
    mapping(string => mapping(address => uint)) private balances;
    string[] private banks = ["A", "B", "C", "D", "E"];

    function deposit(string memory bank) public payable {
        balances[bank][msg.sender] += msg.value;
    }

    function withdraw(string memory bank, uint amount) public {
        require(balances[bank][msg.sender] >= amount, "Insufficient balance");
        balances[bank][msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(string memory bank) public view returns (uint) {
        return balances[bank][msg.sender];
    }
}

contract Q54 {
/*1. 기부받는 플랫폼을 만드세요. 가장 많이 기부하는 사람을 나타내는 변수와 그 변수를 지속적으로 바꿔주는 함수를 만드세요.
    
    힌트 : 굳이 mapping을 만들 필요는 없습니다.
*/
    address public topDonor;
    uint public highestDonation;

    function donate() public payable {
        if (msg.value > highestDonation) {
            topDonor = msg.sender;
            highestDonation = msg.value;
        }
    }
}

contract Q55 {
/*배포와 함께 owner를 설정하고 owner를 다른 주소로 바꾸는 것은 오직 owner 스스로만 할 수 있게 하십시오.
*/
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "Only owner can change ownership");
        owner = newOwner;
    }
}

contract Q56 {
/*위 문제의 확장버전입니다.
 
  owner와 sub_owner를 설정하고 owner를 바꾸기 위해서는 둘의 동의가 모두 필요하게 구현하세요.
*/
    address public owner;
    address public subOwner;
    bool public ownerAgreed;
    bool public subOwnerAgreed;
    address public proposedOwner;

    constructor() {
        owner = msg.sender;
    }

    function setSubOwner(address _subOwner) public {
        require(msg.sender == owner, "Only owner can set sub-owner");
        subOwner = _subOwner;
    }

    function proposeNewOwner(address _proposedOwner) public {
        require(msg.sender == owner || msg.sender == subOwner, "Only owner or sub-owner can propose");
        proposedOwner = _proposedOwner;
        ownerAgreed = false;
        subOwnerAgreed = false;
    }

    function agreeToChangeOwner() public {
        require(msg.sender == owner || msg.sender == subOwner, "Only owner or sub-owner can agree");
        if (msg.sender == owner) ownerAgreed = true;
        if (msg.sender == subOwner) subOwnerAgreed = true;

        if (ownerAgreed && subOwnerAgreed) {
            owner = proposedOwner;
            proposedOwner = address(0);
        }
    }
}

contract Q57 {
/*위 문제의 또다른 버전입니다. 
  
  owner가 변경할 때는 바로 변경가능하게 sub-owner가 변경하려고 한다면 owner의 동의가 필요하게 구현하세요.
*/
    address public owner;
    address public subOwner;
    address public proposedOwner;

    constructor() {
        owner = msg.sender;
    }

    function setSubOwner(address _subOwner) public {
        require(msg.sender == owner, "Only owner can set sub-owner");
        subOwner = _subOwner;
    }

    function changeOwner(address newOwner) public {
        if (msg.sender == owner) {
            owner = newOwner;
        } else if (msg.sender == subOwner) {
            proposedOwner = newOwner;
        }
    }

    function approveOwnerChange() public {
        require(msg.sender == owner, "Only owner can approve");
        require(proposedOwner != address(0), "No proposed owner");
        owner = proposedOwner;
        proposedOwner = address(0);
    }
}

contract Q58 {
/*A contract에 a,b,c라는 상태변수가 있습니다. 

  a는 A 외부에서는 변화할 수 없게 하고 싶습니다. 
 
  b는 상속받은 contract들만 변경시킬 수 있습니다. 
  
  c는 제한이 없습니다. 각 변수들의 visibility를 설정하세요.
*/
    uint private a;
    uint internal b;
    uint public c;
}

contract Q59 {
/*현재시간을 받고 2일 후의 시간을 설정하는 함수를 같이 구현하세요.
*/
    function PlusTwoDays() public view returns (uint) {
        return block.timestamp + 2 days;
    } 
}

contract Q60 {
/*1. 방이 2개 밖에 없는 펜션을 여러분이 운영합니다. 

    각 방마다 한번에 3명 이상 투숙객이 있을 수는 없습니다. 

    특정 날짜에 특정 방에 누가 투숙했는지 알려주는 자료구조와 그 자료구조로부터 값을 얻어오는 함수를 구현하세요.
    
    예약시스템은 운영하지 않아도 됩니다. 과거의 일만 기록한다고 생각하세요.
    
    힌트 : 날짜는 그냥 숫자로 기입하세요. 예) 2023년 5월 27일 → 230527
*/
    mapping(uint => mapping(uint => address[])) private bookings; // date => room => guests

    function addBooking(uint date, uint room, address[] memory guests) public {
        require(room == 1 || room == 2, "Invalid room number");
        require(guests.length <= 3, "Too many guests");
        bookings[date][room] = guests;
    }

    function getBooking(uint date, uint room) public view returns (address[] memory) {
        return bookings[date][room];
    }
}