//
//  ViewController.swift
//  RetoFinancieraOh
//
//  Created by Cesar Sosa  on 24/04/19.
//  Copyright © 2019 Cesar Sosa . All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

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
        else
        {
            self.performSegue(withIdentifier: "toClientVC", sender: self)
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    


}

