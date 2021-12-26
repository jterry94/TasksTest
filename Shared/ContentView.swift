//
//  ContentView.swift
//  Shared
//
//  Created by Jeff_Terry on 12/26/21.
//

import SwiftUI



struct ContentView: View {
    
    @State var calculationString = ""
    @State private var enableButton = true
    
    var body: some View {
        VStack{
            TextEditor(text: $calculationString)
            Divider()
            Button("Begin Calculation", action: self.startCalculation)
                .disabled(enableButton == false)
        }
        
        
    }
    
    func startCalculation(){
        
        enableButton = false  
        slowMath()
    }
    
    func slowMath() {
        
        
        
        Task{
            
            await updateGUI(text: "Start time \(Date())\n")
            
            let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                
        for i in stride(from: 0, through: 25, by: 1){
            
            taskGroup.addTask {
                
                
            await slowSum(i: i, addend1: Double.random(in: 0.0...100.0), addend2: Double.random(in: 0.0...100.0), randomSleep: UInt32(Int.random(in: 1...5)))
                
            }
            
            
            }
        }
            
            await updateGUI(text: "End time \(Date())\n")
            
            await setButtonEnable(state: true)
                                                 
        }
        
    }
    
    @MainActor func setButtonEnable(state: Bool){
        
        if state {
            
            enableButton = true
        }
        else{
            
            enableButton = false
        }
        
    }
    
    @MainActor func updateGUI(text:String){
        
        calculationString += text
        
    }
    
    func slowSum(i: Int, addend1: Double, addend2: Double, randomSleep: UInt32) async{
        
        let sum = addend1 + addend2
        
        sleep(randomSleep)
        
        let returnText = "The sum of the \(i)th addition \(addend1) and \(addend2) is \(sum) with sleep time \(randomSleep) sec.\n"
        
        await updateGUI(text: returnText)
        
        
    }


}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
