//
//  PatientDetailsViewController.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 25/02/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class PatientDetailsViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genLabel: UILabel!
    
    var viewModel: PatientDetailsViewModel?
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblView.tableFooterView = UIView()
        
        self.tblView.reloadData()
        self.nameLabel.text = viewModel?.getPatientName()
        self.idLabel.text = viewModel?.getPatientId()
        self.typeLabel.text = viewModel?.getPatientType()
        self.genLabel.text = viewModel?.getPatientGender()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientDetailsToStudySegue" {
            if let vc = segue.destination as? StudyDetailsViewController,
                let selIndex = self.tblView.indexPathForSelectedRow?.row {
                vc.viewModel = StudyDetailsViewModel(id: viewModel?.getCellData(index: selIndex) ?? "")
            }
        }
    }
}

extension PatientDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsInSection() ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
       
        cell?.textLabel?.text = viewModel?.getCellData(index: indexPath.row)
        return cell!
   }
}

