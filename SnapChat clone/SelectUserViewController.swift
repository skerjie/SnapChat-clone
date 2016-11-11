//
//  SelectUserViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 08.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var descr = ""
  var imageURL = ""
  var uuid = ""
  
  var usersArray : [User] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
      print(snapshot)
      
      let user = User()
      user.email = (snapshot.value as! NSDictionary)["email"] as! String
      user.uid = snapshot.key
      
      self.usersArray.append(user)
      self.tableView.reloadData()
    })
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usersArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let user = usersArray[indexPath.row]
    cell.textLabel?.text = user.email
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = usersArray[indexPath.row]
    let snap = ["from":FIRAuth.auth()!.currentUser!.email!, "description" : descr,"imageURL" : imageURL, "uuid" : uuid]
    FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    
    navigationController!.popToRootViewController(animated: true) // возвращает на начальный контроллер
  }
}
