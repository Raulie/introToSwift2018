//
//  PickerManager.swift
//  Homework8_RMC
//
//  Created by Raúl Y. Mora-Colón on 5/8/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

struct PickerManager {
    static let states = [ "Alaska",
                          "Alabama",
                          "Arkansas",
                          "American Samoa",
                          "Arizona",
                          "California",
                          "Colorado",
                          "Connecticut",
                          "District of Columbia",
                          "Delaware",
                          "Florida",
                          "Georgia",
                          "Guam",
                          "Hawaii",
                          "Iowa",
                          "Idaho",
                          "Illinois",
                          "Indiana",
                          "Kansas",
                          "Kentucky",
                          "Louisiana",
                          "Massachusetts",
                          "Maryland",
                          "Maine",
                          "Michigan",
                          "Minnesota",
                          "Missouri",
                          "Mississippi",
                          "Montana",
                          "North Carolina",
                          " North Dakota",
                          "Nebraska",
                          "New Hampshire",
                          "New Jersey",
                          "New Mexico",
                          "Nevada",
                          "New York",
                          "Ohio",
                          "Oklahoma",
                          "Oregon",
                          "Pennsylvania",
                          "Puerto Rico",
                          "Rhode Island",
                          "South Carolina",
                          "South Dakota",
                          "Tennessee",
                          "Texas",
                          "Utah",
                          "Virginia",
                          "Virgin Islands",
                          "Vermont",
                          "Washington",
                          "Wisconsin",
                          "West Virginia",
                          "Wyoming" ]
    
    static let months = Calendar.current.monthSymbols
    static let currentMonth = Calendar.current.component(.month, from: Date())
    static let currentYear = Calendar.current.component(.year, from: Date())
}

extension PickerManager {
    
    static var years: [String] {
        return (currentYear...currentYear + 20).map { String($0) }
    }

}
