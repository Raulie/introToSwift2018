//
//  CreditCardsViewController.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

class CreditCardsViewController: UIViewController {

    var creditCards = [CreditCard]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Credit Cards"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCreditCardButtonPressed))
        
        loadCreditCards()
    }
    
    @objc private func addNewCreditCardButtonPressed() {
        let newAddressVC = storyboard?.instantiateViewController(withIdentifier: "newCreditCard") as! AddCreditCardViewController
        newAddressVC.delegate = self
        navigationController?.pushViewController(newAddressVC, animated: true)
    }
}

extension CreditCardsViewController: AddCreditCardDelegate {
    func didPressSaveButton(_ creditCard: CreditCard, index: Int?) {
        if let i = index {
            creditCards[i] = creditCard
        } else {
            creditCards.append(creditCard)
        }
        tableView.reloadData()
        saveCreditCards()
    }
}

extension CreditCardsViewController {
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(
            "CreditCards.plist")
    }
    
    func saveCreditCards() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(creditCards)
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding credit cards array!")
        }
    }
    
    func loadCreditCards() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                creditCards = try decoder.decode([CreditCard].self,
                                           from: data)
            } catch {
                print("Error decoding credit card array!")
            }
        }
    }
}

extension CreditCardsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCardSummary", for: indexPath) as! CreditCardSummaryCell
        let creditCard = creditCards[indexPath.row]
        let lastFourDigits = String(creditCard.cardNumber.suffix(4))
        
        cell.nameLabel.text = creditCard.firstName + " " + creditCard.lastName
        cell.cardInfoLabel.text = String(format: "***%@, expires: %@", arguments: [lastFourDigits, creditCard.expirationDate])
        
        return cell
    }
}

extension CreditCardsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newAddressVC = storyboard?.instantiateViewController(withIdentifier: "newCreditCard") as! AddCreditCardViewController
        newAddressVC.delegate = self
        newAddressVC.creditCardIndex = indexPath.row
        newAddressVC.newCreditCard = creditCards[indexPath.row]
        navigationController?.pushViewController(newAddressVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            creditCards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveCreditCards()
        }
    }
}
