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

import LocalAuthentication



class ViewController: UIViewController, GIDSignInUIDelegate, UITextFieldDelegate {

    
       var context = LAContext()
    
    @IBAction func LoginBio(_ sender: Any) {
        
        
        self.stateLabel.text = ""
        
        // Get a fresh context for each login. If you use the same context on multiple attempts
        //  (by commenting out the next line), then a previously successful authentication
        //  causes the next policy evaluation to succeed without testing biometry again.
        //  That's usually not what you want.
        context = LAContext()
        
        context.localizedCancelTitle = "Enter Username/Password"
        
        // First check if we have the needed hardware support.
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                
                if success {
                    
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        self.redirec(withIdentifier: "toClientVC")
                    }
                    
                } else {
                    self.stateLabel.text = "Error en la autenticacion por biometria"
                    
                    // Fall back to a asking for username and password.
                    // ...
                }
            }
        } else {
            self.stateLabel.text = "Error en la autenticacion por biometria(Policy)"
            
            // Fall back to a asking for username and password.
            // ...
        }
       
    }
    
    
    @IBOutlet weak var stateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        
        GIDSignIn.sharedInstance().uiDelegate = self
        phoneTextField.delegate = self
        
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
        if error != nil
        {
            self.stateLabel.text = "Error en la autenticacion por Google"
        }
        
        
    }
    func redirec(withIdentifier identifier:String)
    {
        
        self.stateLabel.text = ""
        
        self.performSegue(withIdentifier: identifier, sender: self)
        
    }
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBAction func validarNumber(_ sender: Any) {
    
        
        self.stateLabel.text = ""
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneTextField.text!, uiDelegate: nil) { (verificationID, error) in
            
            if error != nil {
                
               // self.stateLabel.text = "Error en la autenticacion por celular"
                
                
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
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == phoneTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

