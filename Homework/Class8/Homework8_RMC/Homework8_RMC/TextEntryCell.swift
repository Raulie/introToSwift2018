//
//  TextEntryCell.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

protocol TextEntryDelegate: class {
    func didUpdateField(_ text: String, _ cardDetailCellType: CardDetailSectionCellType?, _ addressCellType: AddressSectionCellType?)
}

class TextEntryCell: UITableViewCell {
    weak var delegate: TextEntryDelegate?
    weak var tableView: UITableView?
    var cardDetailCellType: CardDetailSectionCellType? = nil
    var addressCellType: AddressSectionCellType? = nil
    
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .words
        }
    }
}

extension TextEntryCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let expectedText = (currentText as NSString).replacingCharacters(in: range, with: string)

        if cardDetailCellType == CardDetailSectionCellType.expirationDate {
            if currentText.count == 2 {
                textField.text = textField.text! + "/"
            }
            
            if expectedText.count > 5 {
                return false
            }
            
        } else if cardDetailCellType == CardDetailSectionCellType.cardNumber {
            if expectedText.count > 16 {
                return false
            }
            
        } else if cardDetailCellType == CardDetailSectionCellType.securityCode {
            if expectedText.count > 4 {
                return false
            }
        }
        
        delegate?.didUpdateField(expectedText, cardDetailCellType, addressCellType)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField.tag == CardDetailSectionCellType.expirationDate.rawValue {
            if text.isEmpty {
                textField.text = String(format: "%02d", PickerManager.currentMonth) + "/" + String(PickerManager.currentYear).suffix(2)
            }
        } else if textField.tag == ( AddressSectionCellType.state.rawValue + CardDetailSectionCellType.count ) {
            if text.isEmpty {
                textField.text = PickerManager.states[0]
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        focusNextField(tag: textField.tag)
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            delegate?.didUpdateField(text, cardDetailCellType, addressCellType)
        }
    }
}

extension TextEntryCell {
    private func focusNextField(tag: Int) {
        if let nextField = tableView?.viewWithTag(tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
    }
}
