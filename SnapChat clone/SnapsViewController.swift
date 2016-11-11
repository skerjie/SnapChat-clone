//
//  SnapsViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 08.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var snapsArray : [Snap] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
      print(snapshot)
      
      let snap = Snap()
      snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
      snap.descr = (snapshot.value as! NSDictionary)["description"] as! String
      snap.from = (snapshot.value as! NSDictionary)["from"] as! String
      snap.key = snapshot.key
      snap.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
      
      
      self.snapsArray.append(snap)
      self.tableView.reloadData()
    })
    
    FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
      print(snapshot)
      //
      //      let snap = Snap()
      //      snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
      //      snap.descr = (snapshot.value as! NSDictionary)["description"] as! String
      //      snap.from = (snapshot.value as! NSDictionary)["from"] as! String
      //      snap.key = snapshot.key
      //
      //
      //      self.snapsArray.append(snap)
      //      self.tableView.reloadData()
      
      var index = 0
      for snap in self.snapsArray {
        if snap.key == snapshot.key {
          self.snapsArray.remove(at: index)
        }
        index += 1
      }
      
      self.tableView.reloadData()
    })
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if snapsArray.count == 0 {
      return 0
    } else {
      return snapsArray.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    if snapsArray.count == 0 {
      cell.textLabel?.text = "You have no snaps! 🙁"
    } else {
      let snap = snapsArray[indexPath.row]
      cell.textLabel?.text = snap.from
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let snap = snapsArray[indexPath.row]
    performSegue(withIdentifier: "viewSnapSegue", sender: snap)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "viewSnapSegue" {
      let dvc = segue.destination as! ViewSnapViewController
      dvc.snap = sender as! Snap
    }
  }
  
  @IBAction func logoutTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
