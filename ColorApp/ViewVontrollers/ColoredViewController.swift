//
//  ColoredViewController.swift
//  ColorApp
//
//  Created by Акира on 07.07.2023.
//

import UIKit


protocol IColoredViewControllerDelegate {
    func changeBackgroundColor(for color: UIColor)
}

class ColoredViewController: UIViewController {
    
    @IBOutlet var labelTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let seccondVC = segue.destination as? SettingsViewController else { return}
        seccondVC.delegate = self
        seccondVC.colorFromFirstScreen = view.backgroundColor ?? .red
        // Как опциональное решение, можно сделать протокол, который обязывает подписавшегося выполнять настройку слайдеров, лейблов и соответственно цвета.
    }
    
}

extension ColoredViewController: IColoredViewControllerDelegate {
    
    func changeBackgroundColor(for color: UIColor) {
        labelTest.text = GoodWordsForMeLovely().meBeCool.randomElement()
        view.backgroundColor = color
    }
    
}
