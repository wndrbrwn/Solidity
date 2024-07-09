// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q21 {
    /* 
        3의 배수만 들어갈 수 있는 array를 구현하세요.
    */
    uint[] public numbers;

    function three(uint _n) public {
        if(_n%3==0) {
            numbers.push(_n);
        }
    }
}

contract Q22 {
    /* 
        2. 뺄셈 함수를 구현하세요. 
        임의의 두 숫자를 넣으면 자동으로 둘 중 큰수로부터 작은 수를 빼는 함수를 구현하세요.    
        예) 2,5 input → 5-2=3(output)
    */
     
    function sub(uint a, uint b) public pure returns (uint) {
        
        if (a >= b) {
            return a - b;
        } else {
            return b - a;
        }
    }
    

}

contract Q23 {
    /* 
        3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.
    */
    function getGrade(uint _n) public pure returns(string memory) {
        if(_n%3==0) {
            return "A";
        } else if(_n%3==1) {
            return "B";
        } else {
            return "C";
        }
    }
}

contract Q24 {
    /* 
        string을 input으로 받는 함수를 구현하세요. “Alice”가 들어왔을 때에만 true를 반환하세요.
    */

    function ifTrue(string memory _name) public pure returns(bool) {
        return keccak256(bytes(_name)) == keccak256(bytes("Alice"));
    }
}

contract Q25 {
    /* 
        배열 A를 선언하고 해당 배열에 n부터 0까지 자동으로 넣는 함수를 구현하세요.  
    */

    uint[] A;

    function setA(uint _n) public {
        for(uint i=_n; i>=0; i--) {
            A.push(i);
            if (i == 0) break;
        }
      
    }

    function getA() public view returns(uint[] memory) {
        return A;}
    
}

contract Q26 {
    /* 
        홀수만 들어가는 array, 짝수만 들어가는 array를 구현하고 숫자를 넣었을 때 자동으로 홀,짝을 나누어 입력시키는 함수를 구현하세요.
    */
    uint[] public oddNumbers;
    uint[] public evenNumbers;

    function splitNumbers(uint[] memory numbers) public {
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers.push(numbers[i]);
            } else {
                oddNumbers.push(numbers[i]);
            }
        }
    }
}

contract Q27 {
    /* 
        string 과 bytes32를 key-value 쌍으로 묶어주는 mapping을 구현하세요. 해당 mapping에 정보를 넣고, 지우고 불러오는 함수도 같이 구현하세요. 
    */

    mapping(string => bytes32) keyValueMapping;

    function setValue(string memory key, bytes32 value) public {
        keyValueMapping[key] = value;
    }

    function deleteValue(string memory key) public {
        delete keyValueMapping[key];
    }

    function getValue(string memory key) public view returns (bytes32) {
        return keyValueMapping[key];
    }
}

contract Q28 {
    /* 
        ID와 PW를 넣으면 해시함수(keccak256)에 둘을 같이 해시값을 반환해주는 함수를 구현하세요.
    */

    function hashIDPW(string memory id, string memory pw) public pure returns (bytes32) {
        bytes32 hashValue = keccak256(abi.encodePacked(id, pw));
        return hashValue;
    }
}

contract Q29 {
    /* 
        숫자형 변수 a와 문자형 변수 b를 각각 10 그리고 “A”의 값으로 배포 직후 설정하는 contract를 구현하세요.
    */

    uint public a;
    string public b;

    constructor() {
        a = 10;
        b = "A";
    }
}

contract Q30 {
    /* 
        10. 임의대로 숫자를 넣으면 알아서 내림차순으로 정렬해주는 함수를 구현하세요
        (sorting 코드 응용 → 약간 까다로움)    
        예 : [2,6,7,4,5,1,9] → [9,7,6,5,4,2,1]
    */
    
    function decending(uint[] memory numbers) public pure returns(uint[] memory) {
        uint[] memory _numbers = numbers;
        for(uint i=0; i<numbers.length; i++) {
            for(uint j=i+1; j<numbers.length; j++) {
                if(_numbers[i] < _numbers[j]) {
                    (_numbers[i], _numbers[j]) = (_numbers[j], _numbers[i]);
                }
            }
        } 

        return _numbers;
    }
}