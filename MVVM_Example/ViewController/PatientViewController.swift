//
//  PatientsVC.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 17/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class PatientViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var viewModel = PatientViewModel()
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblView.tableFooterView = UIView() // remove unused lines
        
        viewModel.getDataFromAPI(url: EndPoint.urlAllPatients) { () in
            DispatchQueue.main.async { [weak self] in
                self?.tblView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientToDetailsSegue" {
            if let vc = segue.destination as? PatientDetailsViewController,
                let selIndex = self.tblView.indexPathForSelectedRow?.row {
                vc.viewModel = PatientDetailsViewModel(data: viewModel.getDatatIndex(index: selIndex))
            }
        }
    }
}

extension PatientViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let cellData = viewModel.getCellData(index: indexPath.row)
        cell?.textLabel?.text = cellData.name
        cell?.detailTextLabel?.text = cellData.patientId
        
        return cell!
    }
}
