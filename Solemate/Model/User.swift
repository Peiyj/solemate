//
//  User.swift
//  Solemate
//
//  Created by Steven Tran on 4/25/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import Foundation

class User {
    
    var userID: Int
    var firstName: String
    var lastName: String
    var gender: String
    var dateOfBirth: Date
    var height: Height
    var weight: Int
    var rehabTime: Int
    var goalBodyWeight: Int
    var condition: String
    var sugeryDate: Date
    
    init() {
        self.userID = 0
        self.firstName = ""
        self.lastName = ""
        self.gender = ""
        self.dateOfBirth = Date()
        self.height = Height()
        self.weight = 0
        self.rehabTime = 0
        self.goalBodyWeight = 0
        self.condition = ""
        self.sugeryDate = Date()
    }
    
    class Date {
        
        var day: Int
        var month: Int
        var year: Int
        
        init() {
            self.day = 0
            self.month = 0
            self.year = 0
        }
        
        init(day: Int, month: Int, year: Int) {
            self.day = day
            self.month = month
            self.year = year
        }
    }
    
    class Height {
    
        var feet: Int
        var inch: Int
        var cm: Int
        
        // Default Constructor
        init() {
            self.feet = 0
            self.inch = 0
            self.cm = 0
        }
        
        // Initialize with ft in
        init(feet: Int, inch: Int) {
            self.feet = feet
            self.inch = inch
            self.cm = Int((Double(feet) * 30.48) + (Double(inch) * 2.54))
        }
        
        // Initialize with cm
        init(cm: Int) {
            self.feet = Int(Double(cm) * 0.0328084)
            self.inch = Int(((Double(cm) * 0.0328084) - Double(feet)) * 12)
            self.cm = cm
        }
    }
}
