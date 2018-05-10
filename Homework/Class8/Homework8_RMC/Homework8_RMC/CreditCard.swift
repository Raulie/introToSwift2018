//
//  CreditCard.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import Foundation

struct CreditCard: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var cardNumber: String = ""
    var expirationDate: String = ""
    var securityCode: String = ""
    var address: Address = Address()
}
extension CreditCard {
    
    var isFilledOut: Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !cardNumber.isEmpty && !expirationDate.isEmpty && !securityCode.isEmpty && address.isFilledOut
    }
    
    func getCardFieldValue(_ type: CardDetailSectionCellType) -> String {
        switch type {
        case .firstName:
            return firstName
        case .lastName:
            return lastName
        case .cardNumber:
            return cardNumber
        case .expirationDate:
            return expirationDate
        case .securityCode:
            return securityCode
        }
    }
    
    func getAddressFieldValue(_ type: AddressSectionCellType) -> String {
        switch type {
        case .addressOne:
            return address.addressOne
        case .addressTwo:
            return address.addressTwo
        case .cityTown:
            return address.cityTown
        case .state:
            return address.state
        case .zipCode:
            return address.zipCode
        }
    }
    
    mutating func updateCardDetail(_ type: CardDetailSectionCellType, _ value: String) -> CreditCard {
        switch type {
        case .firstName:
            firstName = value
        case .lastName:
            lastName = value
        case .cardNumber:
            cardNumber = value
        case .expirationDate:
            expirationDate = value
        case .securityCode:
            securityCode = value
        }
        
        return self
    }
    
    mutating func updateAddressDetail(_ type: AddressSectionCellType, _ value: String) -> CreditCard {
        switch type {
        case .addressOne:
            address.addressOne = value
        case .addressTwo:
            address.addressTwo = value
        case .cityTown:
            address.cityTown = value
        case .state:
            address.state = value
        case .zipCode:
            address.zipCode = value
        }
        return self
    }
}
