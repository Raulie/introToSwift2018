//
//  Message.swift
//  Homework3_RMC
//
//  Created by Raúl Y. Mora-Colón on 4/7/18.
//  Copyright © 2018 Raúl Y. Mora-Colón. All rights reserved.
//

import UIKit

enum MessageState: Int {
    case pending = 1
    case sent = 2
    case failed = 3
}

struct Message {
    var fromName: String
    var body: String
    var state: MessageState
}

extension Message {
    var txt: String {
        var stateTxt = ""
        switch state {
        case .pending:
            stateTxt = "Pending"
        case .sent:
            stateTxt = "Sent"
        case .failed:
            stateTxt = "Failed"
        }
        return "Status: \(stateTxt)"
    }
}

extension Message {
    static var defaultData: [Message] {
        let firstMessage = Message(fromName: "Maria", body: "We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul.", state: .pending)
        let secondMessage = Message(fromName: "Antonio", body: "Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde.", state: .sent)
        let thirdMessage = Message(fromName: "Ricardo", body: "I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home.", state: .failed)
        let fourthMessage = Message(fromName: "Jessica", body: "Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula.", state: .pending)
        let fifthMessage = Message(fromName: "Alex", body: "Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana.", state: .sent)
        
        return [firstMessage, secondMessage, thirdMessage, fourthMessage, fifthMessage];
    }
}
