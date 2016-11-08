//
//  SnapsViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 08.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func logoutTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
