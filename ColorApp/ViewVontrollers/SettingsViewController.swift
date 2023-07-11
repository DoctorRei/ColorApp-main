//
//  ViewController.swift
//  ColorApp
//
//  Created by Акира on 25.05.2023.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var labelRed: UILabel!
    @IBOutlet var labelGreen: UILabel!
    @IBOutlet var labelBlue: UILabel!
    
    @IBOutlet var sliderRed: UISlider!
    @IBOutlet var sliderGreen: UISlider!
    @IBOutlet var sliderBlue: UISlider!
    
    @IBOutlet var labelStaticRed: UILabel!
    @IBOutlet var labelStaticGreen: UILabel!
    @IBOutlet var labelStaticBlue: UILabel!
    
    @IBOutlet var buttonReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLables()
        setupSlidersValues(for: sliderRed, sliderGreen, sliderBlue)
        setupStaticLables()
        
        setupView()
        
        buttonReset.setTitle("RESET", for: .normal)
    }
    
    var delegate: IColoredViewControllerDelegate!
    
    
    // MARK: IBActions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setupView()
        switch sender{
        case sliderRed:
            labelRed.text = fromFloatToString(sender)
        case sliderBlue:
            labelBlue.text = fromFloatToString(sender)
        case sliderGreen:
            labelGreen.text = fromFloatToString(sender)
        default:
            break
        }
    }
    
    @IBAction func tapResetButton() {
        sliderRed.value = 0
        sliderGreen.value = 0
        sliderBlue.value = 0
        setupView()
        setupLables()
    }
    
    @IBAction func tapSaveButton() {
        delegate.changeBackgroundColor()
        dismiss(animated: true)
    }
    
    // MARK: Private Methods
    
    private func setupSlidersValues(for sliders: UISlider...) {
        
        sliders.forEach { slider in
            switch slider {
                
            case sliderRed:
                sliderRed.value = 0
                sliderRed.minimumValue = 0
                sliderRed.maximumValue = 255
                sliderRed.tintColor = .red
                
            case sliderGreen:
                sliderGreen.value = 0
                sliderGreen.minimumValue = 0
                sliderGreen.maximumValue = 255
                sliderGreen.tintColor = .green
                
            case sliderBlue:
                sliderBlue.value = 0
                sliderBlue.minimumValue = 0
                sliderBlue.maximumValue = 255
                sliderBlue.tintColor = .blue
                
            default:
                break
            }
        }
    }
    
    private func setupView() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(sliderRed.value) / 255,
            green: CGFloat(sliderGreen.value) / 255,
            blue: CGFloat(sliderBlue.value) / 255,
            alpha: 1
        )
    }
    
    private func fromFloatToString(_ slider: UISlider) -> String {
        return String(format: "%.f", slider.value)
    }
    
    private func setupLables() {
        labelRed.text = "RGB"
        labelRed.font = .systemFont(ofSize: 14)
        labelStaticRed.text = "Red"
        labelGreen.text = "RGB"
        labelGreen.font = .systemFont(ofSize: 14)
        labelStaticGreen.text = "Green"
        labelBlue.text = "RGB"
        labelBlue.font = .systemFont(ofSize: 14)
        labelStaticBlue.text = "Blue"
    }
    
    private func setupStaticLables() {
        labelStaticRed.text = "Red"
        labelStaticRed.font = .systemFont(ofSize: 14)
        labelStaticGreen.text = "Green"
        labelStaticGreen.font = .systemFont(ofSize: 14)
        labelStaticBlue.text = "Blue"
        labelStaticBlue.font = .systemFont(ofSize: 14)
    }
}


