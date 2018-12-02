//
//  RxCalModel.swift
//  JiSeobApps
//
//  Created by kimjiseob on 02/12/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation



class CalModel {
    
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
    
    
    
    var nowNumber: Double = 0
    var dotCount: Double = 0
    var numberLog: [Double] = []
    
    
    // 숫자 입력
    func inputNumber(_ num:Double) -> String {
        print("input Number: \(num)")
        switch dotCount == 0 {
        case true:
            // 소수점 x
            nowNumber = (nowNumber * 10) + num
            break
        case false:
            // 소수점 o
            nowNumber = nowNumber + (num / (pow(10, dotCount)))
            break
        }
        
        if dotCount != 0 {
            dotCount += 1
        }
        
        return nowNumber.description
    }
    // 사칙 연산 입력
    func inputOperator(_ type: String){
        print("input type: \(type)")
        
        let convertedType = OperatorList.init(rawValue: type)!
        
        switch convertedType {
        case .dot:
            guard dotCount == 0 else { return }
            dotCount = 1
            break
        default:
            break
        }
        
    }
    // 특수 기능 입력
    func inputSpecial() {
        
    }
    
    
    
}
