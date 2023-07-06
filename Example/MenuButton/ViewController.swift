//
//  ViewController.swift
//  MenuButton
//
//  Created by Ihar Katkavets on 07/05/2023.
//  Copyright (c) 2023 Ihar Katkavets. All rights reserved.
//

import UIKit
import MenuButton

class ViewController: UIViewController {
    @IBOutlet var menuButton: MenuButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .small)
        let imageName = "chevron.down"
        let symbolImage = UIImage(systemName: imageName, withConfiguration: symbolConfig)
        menuButton?.imageView.image = symbolImage?.withTintColor(.green, renderingMode: .alwaysOriginal)
        menuButton?.titleLabel.text = "The button long long title".uppercased()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressMenu(_ button: UIButton) {
        print("press menu button")
        
    }

}

