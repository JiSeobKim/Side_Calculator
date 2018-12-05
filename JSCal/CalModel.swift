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
        case mul = "x"
        case div = "/"
    }
    
    enum SpecialList: String {
        case save = "Save"
        case errorClear = "CE"
        case allClear = "AC"
        case dot = "."
        case end = "="
    }
    
    enum CalculatorInputMode {
        case number
        case function
        case operators
    }
    
    
    var resultNumber: Double = 0 {
        didSet {
            let log = getLogText()
            
            guard isFinal == false else { return }
            
            delegate?.endOperator(result: resultNumber.description)
            delegate?.showLogString(logStr: log)
            
        }
    }
    
    var nowNumber: Double = 0
    var dotCount: Double = 0
    var numberLog: [String] = []
    
    var delegate: CalculatorDelegate?
    
    private var isInputNumber: Bool!
    private var isFinal: Bool = false
    private var divAndMulCount = 0
    
    
    // 숫자 입력
    func inputNumber(_ num:Double) {
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
        
        self.isInputNumber = true
        
        let lastOper = numberLog.last ?? ""
        let value = nowNumber.description
        
        delegate?.inputOperator(result: "\(lastOper) \(value)")
    }
    // 사칙 연산 입력
    func inputOperator(_ type: String){
        print("input Operator type: \(type)")
        
        guard isInputNumber == true else {
            guard numberLog.count != 0 else { return }
            numberLog.removeLast()
            numberLog.append(type)
            return
        }
        
        let convertedType = OperatorList.init(rawValue: self.numberLog.last ?? "+")!
        
        numberLog.append(contentsOf: [nowNumber.description, type])
        
        switch convertedType {
        case .add:
            resultNumber += nowNumber
            break
            
        case .sub:
            resultNumber -= nowNumber
            break
            
        case .mul:
            self.divAndMulCount += 1
            resultNumber *= nowNumber
            break
            
        case .div:
            guard nowNumber != 0 else { return }
            self.divAndMulCount += 1
            resultNumber /= nowNumber
            break
        }
        
        
        nowNumber = 0
        
        self.isInputNumber = false
    }
    
    // 특수 기능 입력
    func inputSpecial(_ type: String) {
        print("input Function type: \(type)")
        
        let convertedType = SpecialList.init(rawValue: type)!
        
        switch convertedType {
        case .dot:
            guard dotCount == 0 else { return }
            dotCount = 1
            break
            
        case .end:
            // 마지막 연산 진행
            guard let lastOper = numberLog.last else { return }
            
            inputOperator(lastOper)
            self.endFunctions()
            break
            
        case .allClear:
            self.clearAll()
            break
            
            
            
        default:
            break

        }
        
    }
    
    
    // = 기능
    func endFunctions() {
        self.isFinal = true
        
        let totalLog: String = getLogText()
        
        let tempResult = resultNumber.description
        
        clearAll()
        
        delegate?.inputOperator(result: "0.0")
        delegate?.endOperator(result: tempResult)
        delegate?.showLogString(logStr: totalLog)
        
        
        self.isFinal = false
    }
    
    // Clear
    func clearAll() {
        self.divAndMulCount = 0
        self.nowNumber = 0
        self.resultNumber = 0
        self.numberLog = []
        self.isInputNumber = nil
        
        delegate?.inputOperator(result: "0.0")
        delegate?.endOperator(result: "0.0")
        delegate?.showLogString(logStr: " ")
    }
    
    
    func getLogText() -> String {
        
        var text = ""
        
        let isShowOpenArrow = numberLog.contains("x") || numberLog.contains("/")
        
        for (c, row) in numberLog.enumerated() {
            if c == 0 && isShowOpenArrow && self.divAndMulCount != 0  {
                for _ in 0...self.divAndMulCount - 1  {
                    text += "("
                }
                
                text += " "
            }
            
            if row == "x" || row == "/" && isFinal == false {
                text += ") "
            }
            
            switch self.isFinal {
            case true:
                if c == numberLog.count - 1 {
                    text += "= \(resultNumber)"
                } else {
                    text += "\(row) "
                }
                
            case false:
                text += "\(row) "
                break
            }
            
        }
        return text
        
    }
}
