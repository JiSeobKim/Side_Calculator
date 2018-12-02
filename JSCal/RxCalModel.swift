//
//  RxCalModel.swift
//  JiSeobApps
//
//  Created by kimjiseob on 02/12/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation



class RxCalModel {
    
    enum OperatorList: String {
        case add = "+"
        case sub = "-"
        case mul = "X"
        case div = "/"
        case dot = "."
        case end = "="
    }
    
    enum SpecialList: String {
        case save = "Save"
        case errorClear = "CE"
        case allClear = "AC"
    }
    
    enum CalculatorInputMode {
        case number
        case function
        case operators
    }
    
    
    
    var nowNumber: Float = 0
    var dotCount: Float = 0
    var numberLog: [Float] = []
    
    
    // 숫자 입력
    func inputNumber(num:Float) {
        
        switch dotCount == 0 {
        case true:
            // 소수점 x
            nowNumber = (nowNumber * 10) + num
            break
        case false:
            // 소수점 o
            nowNumber = nowNumber + (num / (powf(10, dotCount)))
            break
        }
        
        print(nowNumber)
    }
    // 사칙 연산 입력
    func inputOperator(){
        
    }
    // 특수 기능 입력
    func inputSpecial() {
        
    }
    
    
    
}
