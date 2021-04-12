//
//  TemperatureViewController.swift
//  TemperatureApp_Programatic
//
//  Created by Benjamin Tincher on 2/9/21.
//

import UIKit

class TemperatureViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        addAllSubviews()
        configureLabels()
        configureButtons()
        constrainAllSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        updateViews()
        activateButtons()
    }
    
    //  MARK: - Properties
    var safeArea: UILayoutGuide {
        return view.safeAreaLayoutGuide
    }
    
    var isCelsius: Bool = false
           
    var buttons: [UIButton] {
        return [calculateButton, calcCtoFButton, calcFtoCButton]
    }
    
    var labels: [UILabel] {
        return [titleLabel, instructionsLabel, startingUnitLabel, resultLabel, resultValueLabel]
    }
    
    
    //  MARK: - Methods
    func addAllSubviews() {
        
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(startingValueTextField)
        view.addSubview(startingUnitLabel)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
        view.addSubview(resultValueLabel)
        view.addSubview(calcCtoFButton)
        view.addSubview(calcFtoCButton)
    }
    
    func constrainAllSubviews() {
        
        titleLabel.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: nil, paddingTop: SpacingConstants.insetTop, paddingBottom: 0, paddingLeading: SpacingConstants.insetLeading, paddingTrailing: 0, width: nil)
        
        instructionsLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: nil, paddingTop: SpacingConstants.neighborOffsetTop, paddingBottom: 0, paddingLeading: SpacingConstants.insetLeading, paddingTrailing: 0, width: nil)
       
        startingValueTextField.anchor(top: instructionsLabel.bottomAnchor, bottom: nil, leading: nil, trailing: safeArea.centerXAnchor, paddingTop: SpacingConstants.neighborOffsetTop, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)

        startingUnitLabel.anchor(top: instructionsLabel.bottomAnchor, bottom: nil, leading: safeArea.centerXAnchor, trailing: nil, paddingTop: SpacingConstants.neighborOffsetTop, paddingBottom: 0, paddingLeading: 4, paddingTrailing: 0, width: 40)
        
        calculateButton.anchor(top: startingValueTextField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: SpacingConstants.neighborOffsetTop, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        
        resultLabel.anchor(top: calculateButton.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: nil, paddingTop: SpacingConstants.neighborOffsetTop, paddingBottom: 0, paddingLeading: SpacingConstants.insetLeading, paddingTrailing: 0)
        
        resultValueLabel.anchor(top: resultLabel.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: nil, paddingTop: SpacingConstants.neighborOffsetTop / 2, paddingBottom: 0, paddingLeading: SpacingConstants.insetLeading, paddingTrailing: 0)
        
        calcCtoFButton.anchor(top: resultValueLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: SpacingConstants.neighborOffsetTop * 4, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        
        calcFtoCButton.anchor(top: calcCtoFButton.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        
    }
    
    @objc func selectButton(sender: UIButton) {
        switch sender {
        case calculateButton:
            calculate()
        default:
            isCelsius.toggle()
            updateViews()
        }
    }
    
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside) }
    }
    
    func configureButtons() {
        for button in buttons {
            button.layer.cornerRadius = 4
            button.layer.masksToBounds = true
            button.backgroundColor = .systemIndigo
            button.setTitle("(buttonTitle)", for: .normal)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.XYdims(width: 200, height: 40)
        }
        
        calculateButton.setTitle("Calculate", for: .normal)
        calcCtoFButton.setTitle("Calculate °C to °F", for: .normal)
        calcFtoCButton.setTitle("Convert °F to °C", for: .normal)
    }
    
    func configureLabels() {
        for label in labels {
            label.backgroundColor = .systemOrange
            label.text = "(labelText)"
            label.layer.cornerRadius = 4
            label.layer.masksToBounds = true
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.textAlignment = .center
            label.XYdims(width: nil, height: 40)
        }
        
        titleLabel.text = "Temperature Converter"
        instructionsLabel.backgroundColor = .clear
        resultLabel.text = "Result:"
        resultLabel.backgroundColor = .clear
        
        startingUnitLabel.text = "°F"
        startingUnitLabel.backgroundColor = .clear
        startingUnitLabel.textAlignment = .left
    }
    
    func calculate() {
        guard let startingValueString = startingValueTextField.text,
              let startingValue = Double(startingValueString) else { return }
        
        let resultValue: Double
        
        if isCelsius {
            resultValue = TemperatureController.shared.calcCtoF(startingValue: startingValue)
            resultValueLabel.text = String(format: "%.1f", resultValue) + "°F"
        } else {
            resultValue = TemperatureController.shared.calcFtoC(startingValue: startingValue)
            resultValueLabel.text = String(format: "%.1f", resultValue) + "°C"
        }
        
        
    }
    
    func updateViews() {
        
        if isCelsius {
            calcCtoFButton.isHidden = true
            calcFtoCButton.isHidden = false
            
            startingValueTextField.text = "0"
            startingUnitLabel.text = "°C"
            resultValueLabel.text = "32°F"
            instructionsLabel.text = "Enter the Temperature in Celsius:"
            startingValueTextField.text = ""
            startingValueTextField.becomeFirstResponder()
        } else {
            calcCtoFButton.isHidden = false
            calcFtoCButton.isHidden = true
            
            calcFtoCButton.isHighlighted = true
            
            startingValueTextField.text = "32"
            resultValueLabel.text = "0°C"
            startingUnitLabel.text = "°F"
            instructionsLabel.text = "Enter the Temperature in Fahrenheit:"
            startingValueTextField.text = ""
            startingValueTextField.becomeFirstResponder()
        }
    }
    
    //  MARK: - Views
    let calculateButton: UIButton = UIButton()
    let titleLabel: UILabel = UILabel()
    let instructionsLabel: UILabel = UILabel()
    let startingUnitLabel: UILabel = UILabel()
    let resultLabel: UILabel = UILabel()
    let resultValueLabel: UILabel = UILabel()
    let calcCtoFButton: UIButton = UIButton()
    let calcFtoCButton: UIButton = UIButton()
    
    var startingValueTextField: UITextField = {
        let textField = UITextField()
        textField.text = "32"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.XYdims(width: 40, height: 40)
        textField.textAlignment = .right
        return textField
    }()

}
