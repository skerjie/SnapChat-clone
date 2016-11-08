//
//  SignInViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 07.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  @IBAction func turnUpTapped(_ sender: Any) {
    
    FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
      print("We trying to signIn")
      if error != nil {
        print("We have an error \(error)")
        FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
          if error != nil {
            print("We have an error \(error)")
          } else {
            print("User created succesfully!")
            self.performSegue(withIdentifier: "signInSegue", sender: nil) // переходим на следующий экран в случае успеха
          }
        })
      } else {
        print("Sigmed In succesfully!")
        self.performSegue(withIdentifier: "signInSegue", sender: nil) // переходим на следующий экран в случае успеха
      }
      
    })
    
  }
}
