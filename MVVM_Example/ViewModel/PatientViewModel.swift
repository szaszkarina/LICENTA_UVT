//
//  PacientsViewModel.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 12/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//


import Foundation

class PatientViewModel {
    typealias completionBlock = () -> ()
    var apiHandler = APIHandlerPatient()
    var datasourceArray = [Patient]()
    
   func getDataFromAPI(url: String, completionBlock : @escaping completionBlock){
        apiHandler.getPatientList(withUrl: url) { [weak self] (patients) in
            self?.datasourceArray = patients
            completionBlock()
        }
    }
    
    func getNumberOfRowsInSection() -> Int {        
        return datasourceArray.count
    }
    
    func getDatatIndex(index : Int) -> Patient {
   
        let patient = datasourceArray[index]
        return patient
    }
    
    func getCellData(index : Int) -> (name: String, patientId: String) {
        let patient = self.getDatatIndex(index: index)
        return (patient.name, patient.patientId)
    }
}
