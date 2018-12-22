//
//  WorkoutVC.swift
//  FitTrack
//
//  Created by Connor Buckley on 12/3/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import UIKit
import Firebase

class WorkoutVC: UIViewController {
    
    //outlets
    
    @IBOutlet weak var val1: UILabel!
    @IBOutlet weak var val2: UILabel!
    @IBOutlet weak var val3: UILabel!
    @IBOutlet weak var val4: UILabel!
    @IBOutlet weak var val5: UILabel!
    
    @IBOutlet weak var leftVal1: UILabel!
    @IBOutlet weak var leftVal2: UILabel!
    @IBOutlet weak var leftVal3: UILabel!
    @IBOutlet weak var leftVal4: UILabel!
    @IBOutlet weak var leftVal5: UILabel!
    
    
    //reset user's progress to 0 in UI and database
    
    @IBAction func resetProgress(_ sender: Any) {
        
        //update UI
        self.val1.text = "0%"
        self.val2.text = "0%"
        self.val3.text = "0%"
        self.val4.text = "0%"
        self.val5.text = "0%"
        
        //set up database access
        let uID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        
        //update values in database
        ref.child("users/\(uID ?? "userID")/chestProgress").setValue("0")
        ref.child("users/\(uID ?? "userID")/legsProgress").setValue("0")
        ref.child("users/\(uID ?? "userID")/backProgress").setValue("0")
        ref.child("users/\(uID ?? "userID")/armsProgress").setValue("0")
        ref.child("users/\(uID ?? "userID")/cardioProgress").setValue("0")
        
        //update UI
        self.leftVal1.text = "4 more sets"
        self.leftVal2.text = "4 more sets"
        self.leftVal3.text = "4 more sets"
        self.leftVal4.text = "4 more sets"
        self.leftVal5.text = "4 more sets"
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setup database access
        
        let ref = Database.database().reference()
        //ref.child("users/\(uID ?? "userID")/numWeights")
        
        let userID = Auth.auth().currentUser?.uid
        
        //observe data from DB once
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            //loads values into vars
            let existingVals1 = value?["chestProgress"] as? String ?? ""
            let existingVals2 = value?["legsProgress"] as? String ?? ""
            let existingVals3 = value?["backProgress"] as? String ?? ""
            let existingVals4 = value?["armsProgress"] as? String ?? ""
            let existingVals5 = value?["cardioProgress"] as? String ?? ""
            
            //convert values to Double
            let valls1 = Double(existingVals1)!
            let valls2 = Double(existingVals2)!
            let valls3 = Double(existingVals3)!
            let valls4 = Double(existingVals4)!
            let valls5 = Double(existingVals5)!
            
            var vals1 = ""
            var vals2 = ""
            var vals3 = ""
            var vals4 = ""
            var vals5 = ""
            
            //set the labels based on math
            if (valls1 >= 4.0) {
                vals1 = "100%"
            } else {
                let num = valls1/4.0
                let num1 = Int(num*100)
                vals1 = "\(num1)%"
            }
            if (valls2 >= 4.0) {
                vals2 = "100%"
            } else {
                let num = valls2/4.0
                let num1 = Int(num*100)
                vals2 = "\(num1)%"
            }
            if (valls3 >= 4.0) {
                vals3 = "100%"
            } else {
                let num = valls3/4.0
                let num1 = Int(num*100)
                vals3 = "\(num1)%"
            }
            if (valls4 >= 4.0) {
                vals4 = "100%"
            } else {
                let num = valls4/4.0
                let num1 = Int(num*100)
                vals4 = "\(num1)%"
            }
            if (valls5 >= 4.0) {
                vals5 = "100%"
            } else {
                let num = valls5/4.0
                let num1 = Int(num*100)
                vals5 = "\(num1)%"
            }
            
            //update text for UI
            self.val1.text = vals1
            self.val2.text = vals2
            self.val3.text = vals3
            self.val4.text = vals4
            self.val5.text = vals5
            
            //update UI based on more math
            if (vals1 == "100%") {
                self.leftVal1.text = "0 more sets"
            } else if (vals1 == "75%") {
                self.leftVal1.text = "1 more sets"
            } else if (vals1 == "50%") {
                self.leftVal1.text = "2 more sets"
            } else if (vals1 == "25%") {
                self.leftVal1.text = "3 more sets"
            } else if (vals1 == "0%") {
                self.leftVal1.text = "4 more sets"
            }
            
            if (vals2 == "100%") {
                self.leftVal2.text = "0 more sets"
            } else if (vals2 == "75%") {
                self.leftVal2.text = "1 more sets"
            } else if (vals2 == "50%") {
                self.leftVal2.text = "2 more sets"
            } else if (vals2 == "25%") {
                self.leftVal2.text = "3 more sets"
            } else if (vals2 == "0%") {
                self.leftVal2.text = "4 more sets"
            }
            
            if (vals3 == "100%") {
                self.leftVal3.text = "0 more sets"
            } else if (vals3 == "75%") {
                self.leftVal3.text = "1 more sets"
            } else if (vals3 == "50%") {
                self.leftVal3.text = "2 more sets"
            } else if (vals3 == "25%") {
                self.leftVal3.text = "3 more sets"
            } else if (vals3 == "0%") {
                self.leftVal3.text = "4 more sets"
            }
            
            if (vals4 == "100%") {
                self.leftVal4.text = "0 more sets"
            } else if (vals4 == "75%") {
                self.leftVal4.text = "1 more sets"
            } else if (vals4 == "50%") {
                self.leftVal4.text = "2 more sets"
            } else if (vals4 == "25%") {
                self.leftVal4.text = "3 more sets"
            } else if (vals4 == "0%") {
                self.leftVal4.text = "4 more sets"
            } 
            
            if (vals5 == "100%") {
                self.leftVal5.text = "0 more sets"
            } else if (vals5 == "75%") {
                self.leftVal5.text = "1 more sets"
            } else if (vals5 == "50%") {
                self.leftVal5.text = "2 more sets"
            } else if (vals5 == "25%") {
                self.leftVal5.text = "3 more sets"
            } else if (vals5 == "0%") {
                self.leftVal5.text = "4 more sets"
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //RELISTING OF VIEW DID LOAD TO REFRESH THE PAGE IN CASE NEW DATA HAS ARRIVED
        
        //setup database access
        
        let ref = Database.database().reference()
        //ref.child("users/\(uID ?? "userID")/numWeights")
        let userID = Auth.auth().currentUser?.uid
        
        //read values from DB
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            //load values
            let existingVals1 = value?["chestProgress"] as? String ?? ""
            let existingVals2 = value?["legsProgress"] as? String ?? ""
            let existingVals3 = value?["backProgress"] as? String ?? ""
            let existingVals4 = value?["armsProgress"] as? String ?? ""
            let existingVals5 = value?["cardioProgress"] as? String ?? ""
            
            //convert to double
            let valls1 = Double(existingVals1)!
            let valls2 = Double(existingVals2)!
            let valls3 = Double(existingVals3)!
            let valls4 = Double(existingVals4)!
            let valls5 = Double(existingVals5)!
            
            var vals1 = ""
            var vals2 = ""
            var vals3 = ""
            var vals4 = ""
            var vals5 = ""
            
            //set the labels based on math
            if (valls1 >= 4.0) {
                vals1 = "100%"
            } else {
                let num = valls1/4.0
                let num1 = Int(num*100)
                vals1 = "\(num1)%"
            }
            if (valls2 >= 4.0) {
                vals2 = "100%"
            } else {
                let num = valls2/4.0
                let num1 = Int(num*100)
                vals2 = "\(num1)%"
            }
            if (valls3 >= 4.0) {
                vals3 = "100%"
            } else {
                let num = valls3/4.0
                let num1 = Int(num*100)
                vals3 = "\(num1)%"
            }
            if (valls4 >= 4.0) {
                vals4 = "100%"
            } else {
                let num = valls4/4.0
                let num1 = Int(num*100)
                vals4 = "\(num1)%"
            }
            if (valls5 >= 4.0) {
                vals5 = "100%"
            } else {
                let num = valls5/4.0
                let num1 = Int(num*100)
                vals5 = "\(num1)%"
            }
            
            //update text
            self.val1.text = vals1
            self.val2.text = vals2
            self.val3.text = vals3
            self.val4.text = vals4
            self.val5.text = vals5
            
            //update UI based on math
            if (vals1 == "100%") {
                self.leftVal1.text = "0 more sets"
            } else if (vals1 == "75%") {
                self.leftVal1.text = "1 more sets"
            } else if (vals1 == "50%") {
                self.leftVal1.text = "2 more sets"
            } else if (vals1 == "25%") {
                self.leftVal1.text = "3 more sets"
            } else if (vals1 == "0%") {
                self.leftVal1.text = "4 more sets"
            }
            
            if (vals2 == "100%") {
                self.leftVal2.text = "0 more sets"
            } else if (vals2 == "75%") {
                self.leftVal2.text = "1 more sets"
            } else if (vals2 == "50%") {
                self.leftVal2.text = "2 more sets"
            } else if (vals2 == "25%") {
                self.leftVal2.text = "3 more sets"
            } else if (vals2 == "0%") {
                self.leftVal2.text = "4 more sets"
            }
            
            if (vals3 == "100%") {
                self.leftVal3.text = "0 more sets"
            } else if (vals3 == "75%") {
                self.leftVal3.text = "1 more sets"
            } else if (vals3 == "50%") {
                self.leftVal3.text = "2 more sets"
            } else if (vals3 == "25%") {
                self.leftVal3.text = "3 more sets"
            } else if (vals3 == "0%") {
                self.leftVal3.text = "4 more sets"
            }
            
            if (vals4 == "100%") {
                self.leftVal4.text = "0 more sets"
            } else if (vals4 == "75%") {
                self.leftVal4.text = "1 more sets"
            } else if (vals4 == "50%") {
                self.leftVal4.text = "2 more sets"
            } else if (vals4 == "25%") {
                self.leftVal4.text = "3 more sets"
            } else if (vals4 == "0%") {
                self.leftVal4.text = "4 more sets"
            }
            
            if (vals5 == "100%") {
                self.leftVal5.text = "0 more sets"
            } else if (vals5 == "75%") {
                self.leftVal5.text = "1 more sets"
            } else if (vals5 == "50%") {
                self.leftVal5.text = "2 more sets"
            } else if (vals5 == "25%") {
                self.leftVal5.text = "3 more sets"
            } else if (vals5 == "0%") {
                self.leftVal5.text = "4 more sets"
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
  
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
