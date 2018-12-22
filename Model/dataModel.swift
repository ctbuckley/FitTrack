//
//  dataModel.swift
//  FitTrack
//
//  Created by Connor Buckley on 12/6/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import Foundation
import Firebase

class dataModel {
    
    static let sharedInstance = dataModel()
    
    //var numbers : [Double] = [144.0, 150.0, 152.0, 156.0]
    
    var numbers : [Double] = []
    
    var targetWeight : Double = 0
    
    var currentWeight : Double = 0
    
    init () {
        
        //load from database or initialize to 1 entry -> currentWeight
        //also set targetWeight and currentWeight
        
        let ref = Database.database().reference()
        //ref.child("users/\(uID ?? "userID")/numWeights")
        
        let userID = Auth.auth().currentUser?.uid
        
        //update the database
        //observe data
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            //first get the data
            let numEntries = value?["numWeights"] as? String ?? ""
            let target = value?["targetWeight"] as? String ?? ""
            
            var numPP = Int(numEntries)!
            numPP-=1
            let numPPStr = String(numPP)
            let curr = value?["currentWeight" + numPPStr] as? String ?? ""
            
            //initialize target and curr
            self.targetWeight = Double(target)!
            self.currentWeight = Double(curr)!
            
            numPP+=1
            
            //initialize the array of weight data
            for index in 0...numPP-1 {
                let indexS = String(index)
                let currV = value?["currentWeight" + indexS] as? String ?? ""
                let val = Double(currV)!
                self.numbers.append(val)
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    //getters
    
    func getNumbers() -> [Double] {
        return numbers
    }
    
    func getMin() -> Double {
        return numbers.min()!
    }
    
    func getMax() -> Double {
        return numbers.max()!
    }
    
    func getCurrentWeight() -> String {
        return "\(currentWeight) lbs"
    }
    
    func getTargetWeight() -> String {
        return "\(targetWeight) lbs"
    }
    
}
