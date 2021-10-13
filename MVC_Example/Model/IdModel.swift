//
//  Studies.swift
//  MVC_Example
//
//  Created by Szasz Karina on 25/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class IdModel: Decodable {
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        id = try container.decode(String.self)
    }
}

