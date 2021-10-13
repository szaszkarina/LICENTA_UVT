//
//  PatientDetailsViewController.swift
//  MVC_Example
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
    
    var patient: Patient = Patient()
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblView.tableFooterView = UIView()
        
        self.tblView.reloadData()
        self.nameLabel.text = patient.name
        self.idLabel.text = patient.patientId
        self.typeLabel.text = patient.type
        self.genLabel.text = patient.gender
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientDetailsToStudySegue" {
            if let vc = segue.destination as? StudyDetailsViewController,
                let selIndex = self.tblView.indexPathForSelectedRow?.row {
                vc.studyId = patient.studies[selIndex]
            }
        }
    }
}

extension PatientDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patient.studies.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
       
        cell?.textLabel?.text = patient.studies[indexPath.row]
        return cell!
   }
}

