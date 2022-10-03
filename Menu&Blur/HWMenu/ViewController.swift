//
//  ViewController.swift
//  Menu&Blur
//
//  Created by Stanislav Sobolevsky on 22.09.22.
//

import UIKit
protocol ViewControllerDelegate {
    func toggleMenu()
}
class ViewController: UIViewController {
    var delegate: ViewControllerDelegate?
    @IBOutlet weak var menuBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonMenu(_ sender: Any) {
        delegate?.toggleMenu()
    }
}
