//
//  AddCreditCardViewController.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

enum CardDetailSectionCellType: Int {
    case firstName
    case lastName
    case cardNumber
    case expirationDate
    case securityCode
    
    var txt: String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .cardNumber:
            return "Card Number"
        case .expirationDate:
            return "Expiration Date"
        case .securityCode:
            return "Security Code"
        }
    }
    
    static var count: Int {
        return CardDetailSectionCellType.securityCode.rawValue + 1
    }
    
}

enum AddressSectionCellType: Int {
    case addressOne
    case addressTwo
    case cityTown
    case state
    case zipCode
    
    var txt: String {
        switch self {
        case .addressOne:
            return "Address One"
        case .addressTwo:
            return "Address Two"
        case .cityTown:
            return "City or Town"
        case .state:
            return "State"
        case .zipCode:
            return "Zip Code"
        }
    }
    
    static var count: Int {
        return AddressSectionCellType.zipCode.rawValue + 1
    }
}

enum NewCreditCardSectionType: Int {
    case cardDetails
    case address
    
    var txt: String {
        switch self {
        case .cardDetails:
            return "Card Details"
        case .address:
            return "Address"
        }
    }
}

protocol AddCreditCardDelegate: class {
    func didPressSaveButton(_ creditCard: CreditCard, index: Int?)
}

class AddCreditCardViewController: UIViewController {
    
    var newCreditCard = CreditCard()
    var creditCardIndex: Int?
    
    var statePickerView = UIPickerView()
    var expirationDatePickerView = UIPickerView()
    
    let statePickerData = PickerManager.states
    let expirationDatePickerMonthData = PickerManager.months
    let expirationDatePickerYearData = PickerManager.years
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: AddCreditCardDelegate?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Credit Card"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        statePickerView.dataSource = self
        statePickerView.delegate = self
        expirationDatePickerView.dataSource = self
        expirationDatePickerView.delegate = self
        
        if creditCardIndex == nil {
            expirationDatePickerView.selectRow(PickerManager.currentMonth - 1, inComponent: 0, animated: true)
        } else {
            if let row = PickerManager.states.index(of: newCreditCard.address.state) {
                statePickerView.selectRow(row, inComponent: 0, animated: false)
            }
            if let month = Int(newCreditCard.expirationDate.prefix(2)) {
                expirationDatePickerView.selectRow(month - 1, inComponent: 0, animated: false)
            }
        }
    }
    
    @objc private func saveButtonPressed() {
        delegate?.didPressSaveButton(newCreditCard, index: creditCardIndex)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = newCreditCard.isFilledOut
    }
}

// MARK: - UITableViewDataSource Methods

extension AddCreditCardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NewCreditCardSectionType(rawValue: section)?.txt
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = NewCreditCardSectionType(rawValue: section)!
        switch sectionType {
        case .cardDetails:
            return CardDetailSectionCellType.count
        case .address:
            return AddressSectionCellType.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = NewCreditCardSectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .cardDetails:
            let cellType = CardDetailSectionCellType(rawValue: indexPath.row)!
            return cardDetailCellFor(cellType, indexPath)
    
        case .address:
            let cellType = AddressSectionCellType(rawValue: indexPath.row)!
            return addressCellFor(cellType, indexPath)
        }
    }
    
    private func cardDetailCellFor(_ cellType: CardDetailSectionCellType, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
        cell.tableView = tableView
        cell.cardDetailCellType = cellType
        cell.textField.tag = cellType.rawValue
        cell.delegate = self
        cell.textField.inputView = nil
        cell.textField.isSecureTextEntry = false
        cell.textField.text = newCreditCard.getCardFieldValue(cellType)
        
        switch cellType {
        case .cardNumber:
            cell.textField.keyboardType = .numberPad
        case .securityCode:
            cell.textField.keyboardType = .numberPad
            cell.textField.isSecureTextEntry = true
        case .expirationDate:
            cell.textField.inputView = expirationDatePickerView
        case .firstName:
            if creditCardIndex == nil {
                cell.textField.becomeFirstResponder()
            }
        default:
            cell.textField.keyboardType = .default
        }

        return cell
    }
    
    private func addressCellFor(_ cellType: AddressSectionCellType, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
        cell.tableView = tableView
        cell.addressCellType = cellType
        cell.textField.text = newCreditCard.getAddressFieldValue(cellType)
        cell.textField.tag = cellType.rawValue + CardDetailSectionCellType.count
        cell.textField.inputView = nil
        cell.delegate = self
        
        switch cellType {
        case .zipCode:
            cell.textField.keyboardType = .numberPad
        case .state:
            cell.textField.inputView = statePickerView
        default:
            cell.textField.keyboardType = .default
        }

        return cell
    }
}

// MARK: - Keyboard Methods

extension AddCreditCardViewController {
    @objc func keyboardWillShow(_ sender: Notification) {
        let height: CGFloat = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height ?? 0
        let duration: TimeInterval = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let curveOption: UInt = (sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.beginFromCurrentState.rawValue|curveOption), animations: {
            let edgeInsets = UIEdgeInsetsMake(0, 0, height, 0)
            self.tableView.contentInset = edgeInsets
            self.tableView.scrollIndicatorInsets = edgeInsets
        }, completion: nil)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        let duration: TimeInterval = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let curveOption: UInt = (sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.beginFromCurrentState.rawValue|curveOption), animations: {
            let edgeInsets = UIEdgeInsets.zero
            self.tableView.contentInset = edgeInsets
            self.tableView.scrollIndicatorInsets = edgeInsets
        }, completion: nil)
    }
}

// MARK: - TextEntryDelegate Methods

extension AddCreditCardViewController: TextEntryDelegate {
    
    func didUpdateField(_ text: String, _ cardDetailCellType: CardDetailSectionCellType?, _ addressCellType: AddressSectionCellType?) {
        
        if let cardDetailCellType = cardDetailCellType {
            newCreditCard = newCreditCard.updateCardDetail(cardDetailCellType, text)
        }
        
        if let addressType = addressCellType {
            newCreditCard = newCreditCard.updateAddressDetail(addressType, text)
        }
        
        updateSaveButton()
    }
    
}

// MARK: - UIPickerViewDataSource Methods

extension AddCreditCardViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == statePickerView {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePickerView {
            return statePickerData.count
        } else {
            if component == 0 {
                return expirationDatePickerMonthData.count
            } else {
                return expirationDatePickerYearData.count
            }
        }
    }
    
    
}

// MARK: - UIPickerViewDelegate Methods

extension AddCreditCardViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePickerView {
            return statePickerData[row]
        } else {
            if component == 0 {
                return expirationDatePickerMonthData[row]
            } else {
                return expirationDatePickerYearData[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePickerView {
            if let textField = tableView?.viewWithTag(AddressSectionCellType.state.rawValue + CardDetailSectionCellType.count) as? UITextField {
                textField.text = statePickerData[row]
                focusNextField(tag: textField.tag)
            }
        } else {
            if let textField = tableView?.viewWithTag(CardDetailSectionCellType.expirationDate.rawValue) as? UITextField {
                if let text = textField.text {
                    var dateComponents = text.split(separator: "/")
                    if component == 0 {
                        textField.text = String(format: "%02d", row + 1) + "/" + String(dateComponents[1])
                        textField.resignFirstResponder()
                        textField.becomeFirstResponder()
                    } else {
                        textField.text = String(dateComponents[0] + "/" + expirationDatePickerYearData[row].suffix(2))
                        focusNextField(tag: textField.tag)
                    }
                }
            }
        }
    }
}
extension AddCreditCardViewController {
    private func focusNextField(tag: Int) {
        if let nextField = tableView?.viewWithTag(tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
    }
}






















