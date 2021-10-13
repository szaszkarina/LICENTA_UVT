//
//  APIHandlerS.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 25/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class APIHandlerStudy {
    
    typealias completionBlock = (Study) -> ()
    
    func getDataFromApi(withUrl strUrlStudy : String, id: String, completionBlock : @escaping completionBlock){
        
        if let unwrappedUrl = URL(string: strUrlStudy + "/" + id) {
            
            URLSession.shared.dataTask(with: unwrappedUrl, completionHandler: { (data, response, error) in
                let study = Study()
                
                if error == nil, let d = data {
                    if let value = String(data: d, encoding: String.Encoding.ascii) {
                        
                        if let jsonData = value.data(using: String.Encoding.utf8) {
                            do {
                                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                                if let mainDicomTags = json["MainDicomTags"] as? [String: String] {
                                    if let description = mainDicomTags["StudyDescription"] {
                                        study.description = description
                                    }
                                    if let studyId = mainDicomTags["StudyID"] {
                                        study.studyId = studyId
                                    }
                                }
                                if let series = json["Series"] as? [String] {
                                    study.series = series
                                }
                                if let id = json["ID"] as? String {
                                    study.id = id
                                }
                                if let type = json["Type"] as? String {
                                    study.type = type
                                }
                                
                            } catch {
                                NSLog("ERROR \(error.localizedDescription)")
                            }
                        }
                    }
                }
                
                completionBlock(study)
                
            }).resume()
        }
    }
    
}
