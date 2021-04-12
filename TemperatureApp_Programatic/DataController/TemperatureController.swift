//
//  TemperatureAndController.swift
//  TemperatureApp_Programatic
//
//  Created by Benjamin Tincher on 2/9/21.
//

import Foundation

class TemperatureController {
    
    static let shared = TemperatureController()
    
    func calcCtoF(startingValue: Double) -> Double {
        let resultValue = ( startingValue * 9 / 5 ) + 32
        return resultValue
    }
    
    func calcFtoC(startingValue: Double) -> Double {
        let resultValue = ( startingValue - 32 ) * 5 / 9
        return resultValue
    }
}
