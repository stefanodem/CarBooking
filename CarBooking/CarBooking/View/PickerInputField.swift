//
//  PickerInputField.swift
//  CarBooking
//
//  Created by De MicheliStefano on 22.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

class PickerInputField: UITextField {
    
    var leftImage: UIImage? {
        didSet{
            updateView()
        }
    }
    
    var picker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(didSetDate(sender:)), for: .valueChanged)
        return picker
    }()
    
    private let pickerToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    
    var imageTintColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
        setupPicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITextField
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 10
        return textRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewWidth = self.leftView?.bounds.width ?? 0
        let textSpacing: CGFloat = 10
        let leftViewspacing: CGFloat = self.leftView?.frame.minX ?? 0.0
        let textOffset = leftViewWidth + leftViewspacing + textSpacing
        return CGRect(origin: CGPoint(x: textOffset, y: 0), size: bounds.size)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewWidth = self.leftView?.bounds.width ?? 0.0
        let leftViewspacing: CGFloat = self.leftView?.frame.minX ?? 0.0
        let textSpacing: CGFloat = 10
        let textOffset = leftViewWidth + leftViewspacing + textSpacing
        return CGRect(origin: CGPoint(x: textOffset, y: 0), size: bounds.size)
    }
    
    // MARK: - Configuration
    private func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = imageTintColor
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }
    
    private func setupPicker() {
        self.inputView = picker
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        pickerToolBar.setItems([doneButton], animated: false)
        self.inputAccessoryView = pickerToolBar
        
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc func didSetDate(sender: UIDatePicker) {
        let date = sender.date
        self.text = formatToString(date)
    }
    
    private func formatToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        return dateFormatter.string(from: date)
    }
    
}

