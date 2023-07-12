//
//  ViewController.swift
//  ColorApp
//
//  Created by Акира on 25.05.2023.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var textFieldRed: UITextField!
    @IBOutlet var textFieldGreen: UITextField!
    @IBOutlet var textFieldBlue: UITextField!
    
    @IBOutlet var sliderRed: UISlider!
    @IBOutlet var sliderGreen: UISlider!
    @IBOutlet var sliderBlue: UISlider!
    
    @IBOutlet var labelStaticRed: UILabel!
    @IBOutlet var labelStaticGreen: UILabel!
    @IBOutlet var labelStaticBlue: UILabel!
    
    @IBOutlet var buttonReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldRed.delegate = self
        textFieldGreen.delegate = self
        textFieldBlue.delegate = self
        
        mainView.backgroundColor = colorFromFirstScreen
        setupBasicSlidersValues(for: sliderRed, sliderBlue, sliderGreen)
        setupStaticLables()
        
        buttonReset.setTitle("RESET", for: .normal)
        
        setupSliders(for: colorFromFirstScreen)
        setupLables()
    }
    
    var delegate: IColoredViewControllerDelegate!
    
    var colorFromFirstScreen: UIColor!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textFieldRed.endEditing(true)
        textFieldGreen.endEditing(true)
        textFieldBlue.endEditing(true)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setupView()
        
        switch sender{
        case sliderRed:
            textFieldRed.text = fromFloatToString(sender)
        case sliderBlue:
            textFieldBlue.text = fromFloatToString(sender)
        case sliderGreen:
            textFieldGreen.text = fromFloatToString(sender)
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
        delegate.changeBackgroundColor(for: mainView.backgroundColor ?? .blue)
            
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupBasicSlidersValues(for sliders: UISlider...) {
        sliders.forEach { slider in
            
            slider.minimumValue = 0
            slider.maximumValue = 255
            
            setupSliderTintColor(for: slider)
        }
    }
    
    private func setupSliderTintColor(for sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
                
            case sliderRed:
                sliderRed.tintColor = .red
            case sliderGreen:
                sliderGreen.tintColor = .green
            case sliderBlue:
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
    
    
    private func setupSliders(for color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        // я долго вкуривал. Тут я принимаю цвет извне. Функция прогоняет его и разбирает на части. Присваивает значения ранее объявленным переменным. После чего берет эти значения и передает в значение слайдеров
        
        sliderRed.value = Float(red) * 255
        sliderGreen.value = Float(green) * 255
        sliderBlue.value = Float(blue) * 255
        
    }
    
    private func setupLables() { // не вините меня за эти длинные методы. Если я сделаю тот же фор ич со свитчом, то кода станет еще больше. И принципиально ничего не изменится. Даже красивее код не станет. Да и в принципе это все пережиток того, что я не хотел вбивать значения в сториборде и сделал кодом для практики. Сетап Слайдерс я переделал в красивый вариант, но все равно это просто настройка значений без дополнительной логики. Выше я сделал красивый аналог, который между внесенными данными красиво бегает. Если критично - могу так же делать
        
        textFieldRed.text = fromFloatToString(sliderRed)
        textFieldRed.font = .systemFont(ofSize: 14)
        labelStaticRed.text = "Red"
        textFieldGreen.text = fromFloatToString(sliderGreen)
        textFieldGreen.font = .systemFont(ofSize: 14)
        labelStaticGreen.text = "Green"
        textFieldBlue.text = fromFloatToString(sliderBlue)
        textFieldBlue.font = .systemFont(ofSize: 14)
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
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Эй",
            message: "Введи значение от 0 до 255",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else {
            return true
        }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Проверяем, превышает ли новая строка 3 символа
        if newText.count > 3 {
            showAlert()
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        // Тут проверяем, пустое ли значение и если да - возвращаем старое значение
        if text.isEmpty {
            // Восстанавливаем предыдущее значение
            switch textField {
            case textFieldRed:
                textFieldRed.text = fromFloatToString(sliderRed)
            case textFieldGreen:
                textFieldGreen.text = fromFloatToString(sliderGreen)
            case textFieldBlue:
                textFieldBlue.text = fromFloatToString(sliderBlue)
            default:
                break
            }
        } else {
            // Ставим значение от нуля до 255. Если выше или ниже - алерт
            if let value = Float(text), value < 0 || value > 255 {
                showAlert()
                return
            }
            
            // На основе введенных данных обновляем значение слайдера, а значит и цвет
            switch textField {
            case textFieldRed:
                sliderRed.value = Float(text) ?? 0
                setupView()
            case textFieldGreen:
                sliderGreen.value = Float(text) ?? 0
                setupView()
            case textFieldBlue:
                sliderBlue.value = Float(text) ?? 0
                setupView()
            default:
                break
            }
        }
    }
}
