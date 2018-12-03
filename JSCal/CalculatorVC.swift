//
//  RxCalculatorVC.swift
//  JiSeobApps
//
//  Created by kimjiseob on 30/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    @IBOutlet weak var lbInput: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbLog: UILabel!
    
    var logArray: [String] = [] {
        didSet {
            var text = ""
            for row in logArray {
                text += "\(row) "
            }
            
            self.lbLog.text = text
        }
    }
    var result: Double = 0 {
        didSet {
            print("result = \(result)")
            lbResult.text = result.description
        }
    }
    var typing: Double = 0 {
        didSet {
            print("result = \(typing)")
            lbInput.text = typing.description
        }
    }
    
    var oldOperator: String?
    var lastInputIsOperator = false
    var isReplaceOperator = false
    
    var calModel: CalModel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calModel = CalModel()
        calModel.delegate = self
        calModel.clearAll()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputNum(_ sender: UIButton) {
        let converted = Double(sender.currentTitle!)!
        calModel.inputNumber(converted)
    }
    
    @IBAction func inputOperator(_ sender: UIButton) {
        let str = sender.currentTitle!
        calModel.inputOperator(str)
        inputOperator(result: str)
        
    }
    
    @IBAction func inputFunction(_ sender: UIButton) {
        let str = sender.currentTitle!
        calModel.inputSpecial(str)
    }
}


extension CalculatorVC: CalculatorDelegate {
    func showLogString(logStr: String) {
        self.lbLog.text = logStr
    }
    
    func endOperator(result: String) {
        self.lbResult.text = result
    }
    
    func inputOperator(result: String) {
        self.lbInput.text = result
    }
    
    
}
