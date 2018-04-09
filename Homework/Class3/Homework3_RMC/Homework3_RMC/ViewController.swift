//
//  ViewController.swift
//  Homework3_RMC
//
//  Created by Raúl Y. Mora-Colón on 4/7/18.
//  Copyright © 2018 Raúl Y. Mora-Colón. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fromNameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet var messageButtons: [UIButton]!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        loadMessages()
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButtons()
    }

    private func configureNavigationBar() {
        title = "Messages"
        
        let leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshButtonPressed))
        leftBarButtonItem.tintColor = .darkGray
        
        let rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        rightBarButtonItem.tintColor = .darkGray
        rightBarButtonItem.isEnabled = false
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @IBAction func messageButtonPressed(_ button: UIButton) {
        let index = button.tag - 1
        let message = messages[index]
        fromNameLabel.text = message.fromName
        bodyLabel.text = message.body
        stateLabel.text = message.txt
    }
    
    @objc private func refreshButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    @objc private func editButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    private func loadMessages() {
        messages = Message.defaultData
    }
    
    private func configureButtons() {
        for button in messageButtons {
            let index = button.tag - 1
            let message = messages[index].fromName
            button.setTitle(message, for: .normal)
        }
    }
    
    private func animateButtons() {
        bottomConstraint.constant = 10
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
}

