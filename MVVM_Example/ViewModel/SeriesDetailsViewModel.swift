//
//  PatientsVC.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 17/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class SeriesDetailsViewModel {
    typealias completionBlock = () -> ()
    var apiHandler = APIHandlerSeries()
    var datasource = Serie()
    var serieId: String = ""
    
    init(id: String){
        self.serieId = id
    }
    
    func getDataFromAPI(url: String, completionBlock : @escaping completionBlock){
        apiHandler.getDataFromApi(withUrl: url, id: self.serieId) { [weak self] (serie) in
            self?.datasource = serie
            completionBlock()
        }
    }
    
    func getManufacturer() -> String {
        return datasource.manufacturer
    }
    
    func getModality() -> String {
        return datasource.modality
    }
    
    func getProtocolName() -> String {
        return datasource.protocolName
    }
    
    func getDescription() -> String {
        return datasource.description
    }
    
    func getStationName() -> String {
        return datasource.stationName
    }
    
    func getStatus() -> String {
        return datasource.status
    }
    
    func getType() -> String {
        return datasource.type
    }
}


