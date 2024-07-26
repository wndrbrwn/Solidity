// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";


contract Q61 {
    /*
    a의 b승을 반환하는 함수를 구현하세요.
    */
    
    function power(uint a, uint b) public pure returns (uint) {
        return a ** b;
    }
}

contract Q62 {
    /*
    2개의 숫자를 더하는 함수, 곱하는 함수 a의 b승을 반환하는 함수를 구현하는데
    3개의 함수 모두 2개의 input값이 10을 넘지 않아야 하는 조건을 최대한 효율적으로 구현하세요.
    */

    modifier inputsWithinRange(uint a, uint b) {
        require(a <= 10 && b <= 10, "Inputs must be less than or equal to 10");
        _;
    }

    function add(uint a, uint b) public pure inputsWithinRange(a, b) returns (uint) {
        return a + b;
    }

    function multiply(uint a, uint b) public pure inputsWithinRange(a, b) returns (uint) {
        return a * b;
    }

    function power(uint a, uint b) public pure inputsWithinRange(a, b) returns (uint) {
        return a ** b;
    }
}

contract Q63 {
    /*
    2개 숫자의 차를 나타내는 함수를 구현하세요.
    */

    function subtract(int a, int b) public pure returns (int) {
        return a - b;
    }
}

pragma solidity ^0.8.0;

contract Q64 {
    /*
    지갑 주소를 넣으면 5개의 4bytes로 분할하여 반환해주는 함수를 구현하세요.
    */

    function splitAddress(address addr) public pure returns (bytes4[5] memory _addr) {
        bytes20 addrBytes = bytes20(addr);
        for(uint i = 0; i < 5; i++) {
            _addr[i] = bytes4(addrBytes);
            addrBytes <<= 32;
        }
    }
}

contract Q65 {
    /*
    1. 숫자 3개를 입력하면 그 제곱을 반환하는 함수를 구현하세요. 그 3개 중에서 가운데 출력값만 반환하는 함수를 구현하세요.
    
    예) func A : input → 1,2,3 // output → 1,4,9 | func B : output 4 (1,4,9중 가운데 숫자)
    */

    function square(uint a, uint b, uint c) public pure returns (uint, uint, uint) {
        return (a**2, b**2, c**2);
    }

    function middle(uint a, uint b, uint c) public pure returns (uint) {
        uint[] memory squares = new uint[](3);
        squares[0] = a**2;
        squares[1] = b**2;
        squares[2] = c**2;
        
        return squares[1];
    }
}

contract Q66 {
    /*
    특정 숫자를 입력했을 때 자릿수를 알려주는 함수를 구현하세요. 추가로 그 숫자를 5진수로 표현했을 때는 몇자리 숫자가 될 지 알려주는 함수도 구현하세요.
    */

    function digitCount(uint num) public pure returns (uint) {
        uint count = 0;
        while (num > 0) {
            num /= 10;
            count++;
        }
        return count > 0 ? count : 1; 
    }

    function base5DigitCount(uint num) public pure returns (uint) {
        uint count = 0;
        while (num > 0) {
            num /= 5;
            count++;
        }
        return count > 0 ? count : 1; 
    }
}

contract A {
    /*
    1. 자신의 현재 잔고를 반환하는 함수를 보유한 Contract A와 다른 주소로 돈을 보낼 수 있는 Contract B를 구현하세요.
    
    B의 함수를 이용하여 A에게 전송하고 A의 잔고 변화를 확인하세요.
    */
     
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    receive() external payable {}
}

contract B {
    
    function sendTouser(address payable user, uint amount) public payable {
        require(msg.value >= amount, "Insufficient funds sent");
        user.transfer(amount);
    }
}

contract Q68 {
    /*
    계승(팩토리얼)을 구하는 함수를 구현하세요. 계승은 그 숫자와 같거나 작은 모든 수들을 곱한 값이다. 
    */

    function factorial(uint n) public pure returns (uint) {
        if (n == 0 || n == 1) {
            return 1;
        }
        uint result = 1;
        for (uint i = 2; i <= n; i++) {
            result *= i;
        }
        return result;
    }
}

contract Q69 {
    /*
    1. 숫자 1,2,3을 넣으면 1 and 2 or 3 라고 반환해주는 함수를 구현하세요.
    
    힌트 : 7번 문제(시,분,초로 변환하기)
    */

    using Strings for uint;

    function formatNumbers(uint a, uint b, uint c) public pure returns (string memory) {
        return string(abi.encodePacked(a.toString(), " and ", b.toString(), " or ", c.toString()));
    }
}

contract Q70 {
    /*
    번호와 이름 그리고 bytes로 구성된 고객이라는 구조체를 만드세요. 
    bytes는 번호와 이름을 keccak 함수의 input 값으로 넣어 나온 output값입니다. 
    고객의 정보를 넣고 변화시키는 함수를 구현하세요. 
    */

    struct Customer {
        uint id;
        string name;
        bytes data;
    }

    mapping(uint => Customer) public customers;

    function setCustomer(uint id, string memory name) public {
        bytes memory data = abi.encodePacked(keccak256(abi.encodePacked(id, name)));
        customers[id] = Customer(id, name, data);
    }

    function getCustomer(uint id) public view returns (Customer memory) {
        return customers[id];
    }
}