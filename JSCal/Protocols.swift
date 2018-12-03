//
//  Protocols.swift
//  JSCal
//
//  Created by JiseobKim on 02/12/2018.
//  Copyright © 2018 JiseobKim. All rights reserved.
//

import Foundation


protocol CalculatorDelegate {
    func inputOperator(result: String)
    func endOperator(result: String)
    func showLogString(logStr: String)
}
