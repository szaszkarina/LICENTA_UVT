//
//  StudiesViewModel.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 25/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class PatientDetailsViewModel {
    
    var patient: Patient = Patient()

    init(data: Patient){
        self.patient = data
    }
    
    func getPatientName() -> String {
        return patient.name
    }
    
    func getPatientGender() -> String {
        return patient.gender
    }
    
    func getPatientId() -> String {
        return patient.patientId
    }
    
    func getPatientType() -> String {
        return patient.type
    }
    
    func getNumberOfRowsInSection() -> Int {
        return patient.studies.count
    }
    
    func getSerieAtIndex(index : Int) -> String {
        
        let study = patient.studies[index]
        return study
    }
    
    func getCellData(index : Int) -> String {
        let study = self.getSerieAtIndex(index: index)
        return study
    }
}



