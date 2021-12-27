//
//  MathClass.swift
//  MathClass
//
//  Created by Jeff_Terry on 12/26/21.
//

import Foundation
import Swift

class MathClass :ObservableObject {
    
    @Published var calculationString = ""
    @Published var enableButton = true
    
    /// slowMath
    /// Uses Task and TaskGroup to thread the internals of a Loop so that they run concurrently
    /// Uses await to update the GUI upon completion.
    func slowMath() {
        
        
        
        Task{
            
            await updateGUI(text: "Start time \(Date())\n")
            
            let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                
        for i in stride(from: 0, through: 25, by: 1){
            
            taskGroup.addTask {
                
                
                await self.slowSum(i: i, addend1: Double.random(in: 0.0...100.0), addend2: Double.random(in: 0.0...100.0), randomSleep: UInt32(Int.random(in: 1...5)))
                
            }
            
            
            }
        }
            
            await updateGUI(text: "End time \(Date())\n")
            
            await setButtonEnable(state: true)
                                                 
        }
        
    }
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    @MainActor func setButtonEnable(state: Bool){
        
        if state {
            
            enableButton = true
        }
        else{
            
            enableButton = false
        }
        
    }
    
    /// updateGUI
    /// This adds the text String to the text displayed in the GUI.
    /// This function runs on the Main Thread only
    /// - Parameter text: text to be added so that it can be displayed
    @MainActor func updateGUI(text:String){
        
        calculationString += text
        
    }
    
    /// slowSum
    /// - Parameters:
    ///   - i: interation of the Looop
    ///   - addend1: Double to be added
    ///   - addend2: Second Double to be added
    ///   - randomSleep: Time to sleep to delay the function
    func slowSum(i: Int, addend1: Double, addend2: Double, randomSleep: UInt32) async{
        
        let sum = addend1 + addend2
        
        sleep(randomSleep)
        
        let returnText = "The sum of the \(i)th addition \(addend1) and \(addend2) is \(sum) with sleep time \(randomSleep) sec.\n"
        
        await updateGUI(text: returnText)
        
        
    }
    
    
    
}


