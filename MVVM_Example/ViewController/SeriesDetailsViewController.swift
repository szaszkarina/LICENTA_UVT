//
//  PatientsVC.swift
//  MVVM_Example
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
        
    var viewModel: SeriesDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel?.getDataFromAPI(url: EndPoint.strUrlSeries) { () in
            DispatchQueue.main.async { [weak self] in
                self?.manufacturer.text = self?.viewModel?.getManufacturer()
                self?.modality.text = self?.viewModel?.getModality()
                self?.protocolName.text = self?.viewModel?.getProtocolName()
                self?.serieDescripton.text = self?.viewModel?.getDescription()
                self?.stationName.text = self?.viewModel?.getStationName()
                self?.status.text = self?.viewModel?.getStatus()
                self?.type.text = self?.viewModel?.getType()
            }
        }
    }    
}

