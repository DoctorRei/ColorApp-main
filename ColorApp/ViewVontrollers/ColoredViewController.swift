//
//  ColoredViewController.swift
//  ColorApp
//
//  Created by Акира on 07.07.2023.
//

import UIKit


protocol IColoredViewControllerDelegate {
    func changeBackgroundColor()
}

class ColoredViewController: UIViewController {

    @IBOutlet var labelTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let seccondVC = segue.destination as? SettingsViewController else { return}
        seccondVC.delegate = self
    }

}

extension ColoredViewController: IColoredViewControllerDelegate {
    func changeBackgroundColor() {
        labelTest.text = "Hello"
        view.backgroundColor = .red
    }
    
    
}
