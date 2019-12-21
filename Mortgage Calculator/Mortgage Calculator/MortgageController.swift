//
//  MortgageController.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 12/19/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

class MortgageController {
    
    var payments: [MortgagePayment] = []
    
    func calculateMortgagePayments(principalAmount: Double, downPayment: Double, interestRate: Double, termLength: Double) -> Double {
        let interestRatePercentage = interestRate / (12 * 100)
        let totalPaymentsCount = termLength * 12
        var adjustedPrice = principalAmount - downPayment

        let firstStep = interestRatePercentage * pow(1 + interestRatePercentage, totalPaymentsCount)
        let secondStep = pow(1 + interestRatePercentage, totalPaymentsCount) - 1
        let result = firstStep / secondStep
        
        let monthlyPayment = adjustedPrice * result
        var interest = adjustedPrice * interestRatePercentage
        var principal = monthlyPayment - interest
        
        for _ in 1...Int(totalPaymentsCount) {
            adjustedPrice = adjustedPrice - principal
            payments.append(MortgagePayment(principalAmount: abs(adjustedPrice), downPayment: downPayment, interestRate: interest, termLength: termLength, monthlyPayment: monthlyPayment))
            
            interest = adjustedPrice * interestRatePercentage
            principal = monthlyPayment - interest
        }
        
        return monthlyPayment
    }

}
