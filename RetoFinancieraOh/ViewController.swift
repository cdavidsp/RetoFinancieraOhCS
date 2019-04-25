//
//  ViewController.swift
//  RetoFinancieraOh
//
//  Created by Cesar Sosa  on 24/04/19.
//  Copyright © 2019 Cesar Sosa . All rights reserved.
//

import UIKit

import GoogleSignIn
import Firebase
import FirebaseAuth

class ViewController: UIViewController, GIDSignInUIDelegate {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
        if error != nil
        {
            print("Google Sign In Error")
        }
        
        
    }
    func redirec(withIdentifier identifier:String)
    {
        self.performSegue(withIdentifier: identifier, sender: self)
        
    }
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBAction func validarNumber(_ sender: Any) {
    
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneTextField.text!, uiDelegate: nil) { (verificationID, error) in
            
            if let error = error {
                
                print("error" )
                
                return
                
            }
            
            self.redirec(withIdentifier:"toClientVC")
            }
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    


}

