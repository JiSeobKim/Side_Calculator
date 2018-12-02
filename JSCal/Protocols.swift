//
//  Protocols.swift
//  JSCal
//
//  Created by JiseobKim on 02/12/2018.
//  Copyright © 2018 JiseobKim. All rights reserved.
//

import Foundation


protocol CalculatorDelegate {
    func inputNumber(num: Float)
    func inputOperator()
    func inputSpecial()
}
