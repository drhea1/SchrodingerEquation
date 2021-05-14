//
//  WaveFunction.swift
//  Schrodinger Equation
//
//  Created by Derek Rhea on 3/5/21.
//

import Foundation
import SwiftUI

class WaveFunction: ObservableObject {
    
    @Published var deltaX = 0.1
    @Published var psi0 = 1.0
    @Published var psiFinal = 1.0
    @Published var initX = 0.0
    @Published var finalX = 1.0
    @Published var mass = 1.0
//    @Published let hBar = 6.582119569 * pow(10,-16)
    
// Units of eV angstroms^2
    @Published var hBarSquaredOverM = 7.6201028
    
    @Published var potential = 1.0
    

//     2
//    d psi (x)       - 2m
//  -----------  =   -------(E - V) psi (x)
//         2                2
//       dx           bar{h}
    

    func waveFuncShootingMethod(energy: Double,potential: [Double], xArray: [Double]) -> Double {
        
        let numberOfSteps = (finalX - initX) / deltaX
        var finalDifference = 1.0
        
        var wArray :[Double] = []
        var wPrimeArray :[Double] = []
        var psiArray : [Double] = []
        var finalDifferenceArray: [Double] = []
        var energyArray : [Double] = []
        
        wArray.append(5.0)
        psiArray.append(0.0)
        
        deltaX = xArray[1]-xArray[0]
//        while finalDifference > pow(10,-12) {
            
        for i in 1...xArray.count {
            
                
                wPrimeArray.append((-2.0/hBarSquaredOverM) * (energy - potential[i-1]) * psiArray[i-1])
                
                let newX = xArray[i-1] + deltaX
                
                
                psiArray.append(psiArray[i-1] + wArray[i-1]*deltaX)
                wArray.append(wArray[i-1] + wPrimeArray[i-1]*deltaX)
//            print(xArray[i-1],potential[i-1],psiArray[i-1],wArray[i-1],wPrimeArray[i-1])
            
        }
            
//        }
            
        return psiArray[psiArray.count - 1]
    }
    
    
}
