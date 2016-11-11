//
//  ViewSnapViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 10.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  
  var snap = Snap()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descr
      imageView.sd_setImage(with: URL(string: snap.imageURL))
    }
  
  override func viewWillDisappear(_ animated: Bool) {
    FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
    
    FIRStorage.storage().reference().child("images").child("\(snap.uuid)").delete { (error) in
      print("We delete it!")
    }
  }

}
