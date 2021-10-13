//
//  StudyDetailsViewModel.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 23/04/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class StudyDetailsViewModel {
    typealias completionBlock = () -> ()
    var apiHandler = APIHandlerStudy()
    var datasource = Study()
    var studyId: String = ""
    
    init(id: String){
        self.studyId = id
    }
    
    func getDataFromAPI(url: String, completionBlock : @escaping completionBlock){
        apiHandler.getDataFromApi(withUrl: url, id: self.studyId) { [weak self] (study) in
            self?.datasource = study
            completionBlock()
        }
    }
    
    func getDescription() -> String {
        return datasource.description
    }
    
    func getStudyId() -> String {
        return datasource.studyId
    }
    
    func getType() -> String {
        return datasource.type
    }
    
    func getNumberOfRowsInSection() -> Int {
        return datasource.series.count
    }
    
    func getSerieAtIndex(index : Int) -> String {
        let serie = datasource.series[index]
        return serie
    }
    
    func getCellData(index : Int) -> String {
        let serie = self.getSerieAtIndex(index: index)
        return serie
    }
}
