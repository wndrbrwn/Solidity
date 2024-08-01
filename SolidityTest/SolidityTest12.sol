// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test12{
/*
가능한 모든 것을 inline assembly로 진행하시면 됩니다.
1. 숫자들이 들어가는 동적 array number를 만들고 1~n까지 들어가는 함수를 만드세요.
2. 숫자들이 들어가는 길이 4의 array number2를 만들고 여기에 4개의 숫자를 넣어주는 함수를 만드세요.
3. number의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
4. number2의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
5. number의 k번째 요소를 반환하는 함수를 구현하세요.
6. number2의 k번째 요소를 반환하는 함수를 구현하세요.
*/

uint[] public number;
uint[4] public number2;
    
    function fillArray(uint n) public {
        assembly {
            let lengthSlot := number.slot
         
            sstore(lengthSlot, n)
    
            let dataSlot := keccak256(lengthSlot, 32)

            for { let i := 1 } iszero(gt(i, n)) { i := add(i, 1) }
            {
                sstore(add(dataSlot, sub(i, 1)), i)
            }
        }
    }

   



    function fillNumber2(uint a, uint b, uint c, uint d) public {
         assembly {
            let slot := number2.slot

            sstore(slot, a)
            sstore(add(slot, 1), b)
            sstore(add(slot, 2), c)
            sstore(add(slot, 3), d)
        }
    }
    
    function sumNumber() public view returns (uint) {
    uint sum;
    assembly {
        let lengthSlot := number.slot
        let length := sload(lengthSlot)
        let dataSlot := keccak256(lengthSlot, 32)
        
        for { let i := 0 } lt(i, length) { i := add(i, 1) }
        {
            sum := add(sum, sload(add(dataSlot, i)))
        }
    }
    return sum;
}
    
    function sumNumber2() public view returns (uint) {
    uint sum;
    assembly {
        let slot := number2.slot
   
        sum := add(sum, sload(slot))
        sum := add(sum, sload(add(slot, 1)))
        sum := add(sum, sload(add(slot, 2)))
        sum := add(sum, sload(add(slot, 3)))
    }
    return sum;
}
    
    function getNumberElement(uint k) public view returns (uint) {
    uint element;
    assembly {
        let lengthSlot := number.slot
        let length := sload(lengthSlot)
        
       
        if iszero(lt(k, length)) {
            revert(0, 0)
        }
        
        let dataSlot := keccak256(lengthSlot, 32)
        element := sload(add(dataSlot, k))
    }
    return element;
}
    
    function getNumber2Element(uint k) public view returns (uint) {
    uint element;
    assembly {
     
        if or(lt(k, 0), gt(k, 3)) {
            revert(0, 0)
        }
        
        let slot := number2.slot
        element := sload(add(slot, k))
    }
    return element;
}
}