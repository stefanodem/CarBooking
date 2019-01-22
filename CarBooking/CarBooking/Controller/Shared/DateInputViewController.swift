//
//  DateInputViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 22.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A date input with two input fields which allows users to input start date and number of days.
 */

class DateInputViewController: UIViewController {
    
    enum InputTypes: String {
        case startDate, days
    }
    
    // MARK: - Properties
    lazy var startDate: Date = defaultDate()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    private lazy var startDateInputField: PickerInputField = {
        let pf = PickerInputField()
        pf.picker.setDate(startDate, animated: false)
        pf.picker.datePickerMode = .dateAndTime
        pf.picker.locale = Locale(identifier: Locale.current.identifier)
        pf.leftImage = UIImage(named: "timer")!
        pf.tintColor = .red
        pf.backgroundColor = .gray
        return pf
    }()
    
    private let daysInputField: PickerInputField = {
        let pf = PickerInputField()
        pf.picker.datePickerMode = .date
        pf.picker.locale = Locale(identifier: Locale.current.identifier)
        let maxDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        pf.picker.maximumDate = maxDate
        pf.leftImage = UIImage(named: "clock")!
        pf.tintColor = .red
        pf.backgroundColor = .gray
        return pf
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - Configuration
    private func setupViews() {
        view.addSubview(mainStackView)
        mainStackView.fillSuperview()
        
        mainStackView.addArrangedSubview(startDateInputField)
        mainStackView.addArrangedSubview(daysInputField)
        
        startDateInputField.text = formatToString(startDate)
        daysInputField.text = formatToString(startDate)
    }
    
    // MARK: - Date handlers
    private func defaultDate() -> Date {
        // Sets date to a default value of next day at 9:00am
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let defaultStartDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: tomorrow)!
        return defaultStartDate
    }
    
    private func formatToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        return dateFormatter.string(from: date)
    }

}
