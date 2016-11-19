//
//  RequestViewController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var timeSlotButtonOne: UIButton!
    @IBOutlet var timeSlotButtonTwo: UIButton!
    @IBOutlet var timeSlotButtonThree: UIButton!
    var datePickerView: DatePickerView?
    var selectedTimeSlotButton: UIButton?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "MMM d, h:mm a"
        
        guard let pickerView = Bundle.main.loadNibNamed(String(describing: DatePickerView.self),
                                                        owner: self,
                                                        options: [:])?.first as? DatePickerView else {
                                                            return
        }
        pickerView.delegate = self
        pickerView.frame = CGRect(x: 0,
                                  y: view.frame.size.height,
                                  width: view.frame.size.width,
                                  height: view.frame.size.height / 2)
        view.addSubview(pickerView)
        datePickerView = pickerView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        messageTextView.layer.borderWidth = 0.5
        messageTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc fileprivate func didTapView() {
        if messageTextView.isFirstResponder {
            messageTextView.resignFirstResponder()
        }
    }
    
    @IBAction func didTapTimeSlotButton(_ button: UIButton) {
        switch button {
        case timeSlotButtonOne:
            presentDatePickerView()
        case timeSlotButtonTwo:
            presentDatePickerView()
        case timeSlotButtonThree:
            presentDatePickerView()
        default:
            return
        }
        selectedTimeSlotButton = button
    }
    
    func presentDatePickerView() {
        guard let datePickerView = datePickerView else { return }
        UIView.animate(withDuration: 0.3) {
            datePickerView.frame = CGRect(x: 0,
                                          y: self.view.frame.size.height / 2,
                                          width: self.view.frame.size.width,
                                          height: self.view.frame.size.height / 2)
        }
    }
}

extension RequestViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
        if let view = datePickerView {
            didTapDone(for: view)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count - range.length + text.characters.count < 141
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.characters.count == 0 {
            placeholderLabel.isHidden = false
        }
    }
    
}

extension RequestViewController: DatePickerViewDelegate {
    
    func didTapDone(for datePickerView: DatePickerView) {
        selectedTimeSlotButton?.setTitle(dateFormatter.string(from: datePickerView.datePicker.date), for: .normal)
        UIView.animate(withDuration: 0.3) {
                        datePickerView.frame = CGRect(x: 0,
                                                      y: self.view.frame.size.height,
                                                      width: self.view.frame.size.width,
                                                      height: self.view.frame.size.height / 2)
        }
    }
    
}
