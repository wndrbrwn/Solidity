// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";
contract Test6 {
    /*
숫자를 넣었을 때 그 숫자의 자릿수와 각 자릿수의 숫자를 나열한 결과를 반환하세요.
예) 2 -> 1,   2 // 45 -> 2,   4,5 // 539 -> 3,   5,3,9 // 28712 -> 5,   2,8,7,1,2
--------------------------------------------------------------------------------------------
문자열을 넣었을 때 그 문자열의 자릿수와 문자열을 한 글자씩 분리한 결과를 반환하세요.
예) abde -> 4,   a,b,d,e // fkeadf -> 6,   f,k,e,a,d,f
*/

  using Strings for uint;

    function Number(uint number) public pure returns (string memory) {
        uint temp = number;
        uint digits = 0;
        uint[] memory digitArray = new uint[](20);
        
        while (temp > 0) {
            digitArray[digits] = temp % 10;
            temp /= 10;
            digits++;
        }
        
        string memory result = string(abi.encodePacked(digits.toString(), ",   "));
        
        for (uint i = digits; i > 0; i--) {
            result = string(abi.encodePacked(result, digitArray[i-1].toString()));
            if (i > 1) {
                result = string(abi.encodePacked(result, ","));
            }
        }
        
        return result;
    }
    
    function String(string memory input) public pure returns (string memory) {
        bytes memory inputBytes = bytes(input);
        uint length = inputBytes.length;
        
        string memory result = string(abi.encodePacked(length.toString(), ",   "));
        
        for (uint i = 0; i < length; i++) {
            result = string(abi.encodePacked(result, string(abi.encodePacked(inputBytes[i]))));
            if (i < length - 1) {
                result = string(abi.encodePacked(result, ","));
            }
        }
        
        return result;
    }
}