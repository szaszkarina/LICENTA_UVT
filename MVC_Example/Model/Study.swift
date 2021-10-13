//
//  Studies.swift
//  MVC_Example
//
//  Created by Szasz Karina on 25/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class Study {
    var id: String
    var description: String
    var studyId: String
    var type: String
    var series: [String]
    
    init(){
        self.id = ""
        self.description = ""
        self.studyId = ""
        self.type = ""
        self.series = [String]()
    }
}
