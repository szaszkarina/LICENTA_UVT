//
//  Pacient.swift
//  MVC_Example
//
//  Created by Szasz Karina on 12/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class Patient {
    var id: String
    var name: String
    var studies: [String]
    var patientId: String
    var gender: String
    var type: String
    
    init(){
        self.id = ""
        self.name = ""
        self.studies = [String]()
        self.patientId = ""
        self.gender = ""
        self.type = ""
    }
    
    init(id: String){
        self.id = id
        self.name = ""
        self.studies = [String]()
        self.patientId = ""
        self.gender = ""
        self.type = ""
    }
}
