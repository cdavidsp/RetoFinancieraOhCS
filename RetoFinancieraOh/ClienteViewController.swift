//
//  ClienteViewController.swift
//  RetoFinancieraOh
//
//  Created by Cesar Sosa  on 24/04/19.
//  Copyright © 2019 Cesar Sosa . All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleSignIn


class ClienteViewController: UIViewController {

 
    let ref = Database.database().reference(withPath: "client-items")

    
    //var ref: DatabaseReference!
    
    //ref = Database.database().reference()
    
    @IBOutlet weak var fechaNacimiento: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBAction func save(_ sender: Any) {
        
        
        let clientItem = Client(nombres: nombre.text!, apellidos: apellido.text!, edad: edad.text!, fechaNacimiento: fechaNacimiento.text!)
        
        let clientItemRef = self.ref.childByAutoId()
        
        clientItemRef.setValue(clientItem.toAnyObject())
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func log(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        self.performSegue(withIdentifier: "showLogin", sender: self)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
