//
//  AddVC.swift
//  FitTrack
//
//  Created by Connor Buckley on 12/6/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import UIKit
import Firebase

class AddVC : UIViewController {
    
    //outlets
    
    @IBOutlet weak var chestTF: UILabel!
    
    @IBOutlet weak var legsTF: UILabel!
    
    @IBOutlet weak var val1: UILabel!
    
    @IBOutlet weak var val2: UILabel!
    
    @IBOutlet weak var val3: UILabel!
    
    @IBOutlet weak var val4: UILabel!
    
    @IBOutlet weak var val5: UILabel!
    
    @IBOutlet weak var stepper1: UIStepper!
    
    @IBOutlet weak var stepper2: UIStepper!
    
    @IBOutlet weak var stepper3: UIStepper!
    
    @IBOutlet weak var stepper4: UIStepper!
    
    @IBOutlet weak var stepper5: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //initialize labels
        
        val1.text = "0"
        val2.text = "0"
        val3.text = "0"
        val4.text = "0"
        val5.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //stepper functions update values and UI
    
    @IBAction func stepper1Change(_ sender: UIStepper) {
        let numSplit =  Int(sender.value)
        val1.text = "\(numSplit)"
    }
    
    @IBAction func stepper2Change(_ sender: UIStepper) {
        let numSplit =  Int(sender.value)
        val2.text = "\(numSplit)"
    }
    
    @IBAction func stepper3Change(_ sender: UIStepper) {
        let numSplit =  Int(sender.value)
        val3.text = "\(numSplit)"
    }
    
    @IBAction func stepper4Change(_ sender: UIStepper) {
        let numSplit =  Int(sender.value)
        val4.text = "\(numSplit)"
    }
    
    @IBAction func stepper5Change(_ sender: UIStepper) {
        let numSplit =  Int(sender.value)
        val5.text = "\(numSplit)"
    }
    
    //update 
    
    @IBAction func addWorkout(_ sender: Any) {
        
        let vals1 = stepper1.value
        let vals2 = stepper2.value
        let vals3 = stepper3.value
        let vals4 = stepper4.value
        let vals5 = stepper5.value
        
        stepper1.value = 0
        stepper2.value = 0
        stepper3.value = 0
        stepper4.value = 0
        stepper5.value = 0
        
        val1.text = "0"
        val2.text = "0"
        val3.text = "0"
        val4.text = "0"
        val5.text = "0"
        
        //database stuff
        let uID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            //read database because we need to Add to existing progress
            
            let existingVals1 = value?["chestProgress"] as? String ?? ""
            let existingVals2 = value?["legsProgress"] as? String ?? ""
            let existingVals3 = value?["backProgress"] as? String ?? ""
            let existingVals4 = value?["armsProgress"] as? String ?? ""
            let existingVals5 = value?["cardioProgress"] as? String ?? ""
            
            let valls1 = vals1 + Double(existingVals1)!
            let valls2 = vals2 + Double(existingVals2)!
            let valls3 = vals3 + Double(existingVals3)!
            let valls4 = vals4 + Double(existingVals4)!
            let valls5 = vals5 + Double(existingVals5)!
            
            //update values in database
            ref.child("users/\(uID ?? "userID")/chestProgress").setValue("\(valls1)")
            ref.child("users/\(uID ?? "userID")/legsProgress").setValue("\(valls2)")
            ref.child("users/\(uID ?? "userID")/backProgress").setValue("\(valls3)")
            ref.child("users/\(uID ?? "userID")/armsProgress").setValue("\(valls4)")
            ref.child("users/\(uID ?? "userID")/cardioProgress").setValue("\(valls5)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
}
