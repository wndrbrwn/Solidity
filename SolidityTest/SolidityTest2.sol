// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test2 {

/*
학생 점수관리 프로그램입니다.
여러분은 한 학급을 맡았습니다.
학생은 번호, 이름, 점수로 구성되어 있고(구조체)
가장 점수가 낮은 사람을 집중관리하려고 합니다.

가장 점수가 낮은 사람의 정보를 보여주는 기능,
총 점수 합계, 총 점수 평균을 보여주는 기능,
특정 학생을 반환하는 기능, -> 숫자로 반환
가능하다면 학생 전체를 반환하는 기능을 구현하세요. ([] <- array)
*/

struct Student {
        uint number;
        string name;
        uint score;
    }

    Student[] students;
    uint totalScore;

    function addStudent(uint _number, string memory _name, uint _score) public {
        students.push(Student(_number, _name, _score));
        totalScore += _score;
    }

    function getLowestScoreStudent() public view returns (uint, string memory, uint) {
            
        uint lowestScore = students[0].score;
        uint lowestIndex = 0;
        
        for (uint i = 1; i < students.length; i++) {
            if (students[i].score < lowestScore) {
                lowestScore = students[i].score;
                lowestIndex = i;
            }
        }
        
        return (students[lowestIndex].number, students[lowestIndex].name, students[lowestIndex].score);
    }

    function getTotalScore() public view returns (uint) {
        return totalScore;
    }

    function getAverageScore() public view returns (uint) {
        return totalScore / students.length;
    }

    function getStudent(uint _n) public view returns (uint, string memory, uint) {
      
        return (students[_n].number, students[_n].name, students[_n].score);
    }

    function getAllStudents() public view returns (Student[] memory) {
        return students;
}
}