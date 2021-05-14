//
//  ContentView.swift
//  Shared
//
//  Created by Derek Rhea on 3/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var plotDataModel :PlotDataClass
    @ObservedObject var potentials = InfiniteSquarePotentials()
    @ObservedObject var waveFunction = WaveFunction()
    @ObservedObject var functional = Functional()
    
    var body: some View {
        HStack{
            VStack{
                Text("Graph Type")
                Menu("Graph"){
                    Button("Potential", action: {self.potentialGraph()})
//                    Button("Functional", action: )
                }
            }
            VStack{
                Text("Potential Type")
                Menu("Potential") {
                    Button("Square Well", action: {self.selectPotential(potentialType: "Square Well")})
                    Button("Linear Well", action: {self.selectPotential(potentialType: "Linear Well")})
//                    Button("Parabolic Well", action: )
//                    Button("Square & Linear Well", action: )
//                    Button("Square Barrier", action: )
//                    Button("Triangle Barrier", action: )
//                    Button("Coupled Parabolic Well", action: )
//                    Button("Coupled Square Well & Field", action: )
//                    Button("Harmonic Oscillator", action: )
//                    Button("Kronig Penney", action: )
//                    Button("Variable Kronig Penney", action: )
//                    Button("KP2-a", action: )
//                    Button("default", action: )
//
                }
            }
            VStack{
                Button("Calculate", action: {self.calculate()})
            }
        }
        
        Divider()
        
        HStack{
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
        }
    }
    
// Func to graph potential of the selected potential type
    
    func potentialGraph() {
        
        
        
    }
    
    func selectPotential(potentialType: String) {
        switch potentialType {
        
            case "Square Well":
                potentials.zero()
                
            case "Linear Well":
                potentials.yEqualsX()
            default:
                potentials.zero()

        }
        
        
    }
    
    func calculate() {
        
        var potentialArray : [Double] = []
        var xArray : [Double] = []
        
        functional.energyArray.removeAll()
        functional.functionalArray.removeAll()
        
        
        for item in potentials.potentialArray {
            xArray.append(item.xPoint)
            potentialArray.append(item.yPoint)
        }
//        let energy = 0.83
        for energy in stride(from: 0.0, through: 20.0, by: 0.05) {
            let functionalValue = waveFunction.waveFuncShootingMethod(energy: energy, potential: potentialArray,xArray: xArray)
            functional.energyArray.append(energy)
            functional.functionalArray.append(functionalValue)
        }
        
        for i in 0..<functional.functionalArray.count {
            print(functional.energyArray[i],functional.functionalArray[i])
        }
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
