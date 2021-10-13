//
//  PatientsVC.swift
//  MVC_Example
//
//  Created by Szasz Karina on 17/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//
import UIKit

class SeriesDetailsViewController: UIViewController {
    
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var modality: UILabel!
    @IBOutlet weak var protocolName: UILabel!
    @IBOutlet weak var serieDescripton: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var type: UILabel!
            
    var serieId: String = ""
    var apiHandler = APIHandlerSeries()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiHandler.getDataFromApi(withUrl: EndPoint.strUrlSeries, id: self.serieId) { [weak self] (serie) in
            DispatchQueue.main.async { [weak self] in
                self?.manufacturer.text = serie.manufacturer
                self?.modality.text = serie.modality
                self?.protocolName.text = serie.protocolName
                self?.serieDescripton.text = serie.description
                self?.stationName.text = serie.stationName
                self?.status.text = serie.status
                self?.type.text = serie.type
            }
        }
    }    
}

