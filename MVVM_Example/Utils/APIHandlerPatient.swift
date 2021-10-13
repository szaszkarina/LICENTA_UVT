//
//  APIHandlerP.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 12/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class APIHandlerPatient {
    
    typealias completionBlock = ([Patient]) -> ()
    private typealias patientCompletionBlock = (Patient) -> ()
    
    func getPatientList(withUrl strUrlP : String, completionBlock : @escaping completionBlock){
        
        if let unwrappedUrlP = URL(string: strUrlP){
            
            URLSession.shared.dataTask(with: unwrappedUrlP, completionHandler: { (data, response, error) in
                var patients = [Patient]()
                
                if error == nil && data != nil{
                    let jsonDecoder = JSONDecoder()
                    do {
                        let idModels = try jsonDecoder.decode([IdModel].self, from: data!)
                        for idModel in idModels {
                            self.getPatient(withUrl: strUrlP+"/"+idModel.id) { (result) in
                                patients.append(result)
                                completionBlock(patients)
                            }
                        }
                    } catch {
                        patients = [Patient(id: "Decoding Error")]
                    }
                } else {
                    patients = [Patient(id: "Network Error")]
                }
                completionBlock(patients)
            }).resume()
        }
    }
    
    private func getPatient(withUrl strUrlP : String, completionBlock : @escaping patientCompletionBlock) {
        if let unwrappedUrlP = URL(string: strUrlP) {
            URLSession.shared.dataTask(with: unwrappedUrlP, completionHandler: { (data, response, error) in
                let patient = Patient()
                if error == nil, let d = data {
                    if let value = String(data: d, encoding: String.Encoding.ascii) {
                        
                        if let jsonData = value.data(using: String.Encoding.utf8) {
                            do {
                                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                                if let mainDicomTags = json["MainDicomTags"] as? [String: String] {
                                    if let name = mainDicomTags["PatientName"] {
                                        patient.name = name
                                    }
                                    if let patientId = mainDicomTags["PatientID"] {
                                        patient.patientId = patientId
                                    }
                                    if let gender = mainDicomTags["PatientSex"] {
                                        patient.gender = gender
                                    }
                                }
                                if let studies = json["Studies"] as? [String] {
                                    patient.studies = studies
                                }
                                if let id = json["ID"] as? String {
                                    patient.id = id
                                }
                                if let type = json["Type"] as? String {
                                    patient.type = type
                                }
                                
                            } catch {
                                NSLog("ERROR \(error.localizedDescription)")
                            }
                        }
                    }
                }
                
                completionBlock(patient)
                
            }).resume()
        }
    }
    
}


