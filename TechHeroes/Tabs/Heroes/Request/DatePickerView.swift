//
//  DatePickerView.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/18/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate: class {
    
    func didTapDone(for datePickerView: DatePickerView)
    
}

class DatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func didTapBarButton(_ sender: Any) {
        delegate?.didTapDone(for: self)
    }
    
}
