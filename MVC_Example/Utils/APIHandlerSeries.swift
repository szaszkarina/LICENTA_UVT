//
//  PatientsVC.swift
//  MVC_Example
//
//  Created by Szasz Karina on 17/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class APIHandlerSeries {
    
    typealias completionBlock = (Serie) -> ()
    
    func getDataFromApi(withUrl strUrl : String, id: String, completionBlock : @escaping completionBlock){
        
        if let unwrappedUrl = URL(string: strUrl + "/" + id){
            
            URLSession.shared.dataTask(with: unwrappedUrl, completionHandler: { (data, response, error) in
                let serie = Serie()
                
                if error == nil, let d = data {
                    if let value = String(data: d, encoding: String.Encoding.ascii) {
                        
                        if let jsonData = value.data(using: String.Encoding.utf8) {
                            do {
                                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                                if let mainDicomTags = json["MainDicomTags"] as? [String: String] {
                                    if let manufacturer = mainDicomTags["Manufacturer"] {
                                        serie.manufacturer = manufacturer
                                    }
                                    if let protocolName = mainDicomTags["ProtocolName"] {
                                        serie.protocolName = protocolName
                                    }
                                    if let description = mainDicomTags["SeriesDescription"] {
                                        serie.description = description
                                    }
                                    if let station = mainDicomTags["StationName"] {
                                        serie.stationName = station
                                    }
                                    if let modality = mainDicomTags["Modality"] {
                                        serie.modality = modality
                                    }
                                }
                                if let status = json["Status"] as? String {
                                    serie.status = status
                                }
                                if let id = json["ID"] as? String {
                                    serie.id = id
                                }
                                if let type = json["Type"] as? String {
                                    serie.type = type
                                }
                                
                            } catch {
                                NSLog("ERROR \(error.localizedDescription)")
                            }
                        }
                    }
                }
                
                completionBlock(serie)
                
            }).resume()
        }
    }
    
}
