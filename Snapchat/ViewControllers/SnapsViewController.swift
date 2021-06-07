//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Javier Flores Càrdenas on 6/2/21.
//  Copyright © 2021 Javier Flores Càrdenas. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func cerrarSesionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
