//
//  StudyDetailsViewController.swift
//  MVC_Example
//
//  Created by Szasz Karina on 23/04/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class StudyDetailsViewController:  UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var studyDescription: UILabel!
    @IBOutlet weak var studyIdLabel: UILabel!
    @IBOutlet weak var studyType: UILabel!
    
    var studyId: String = ""
    var apiHandler = APIHandlerStudy()
    var study = Study()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.tableFooterView = UIView()
        
        apiHandler.getDataFromApi(withUrl: EndPoint.strUrlStudy, id: self.studyId) { [weak self] (study) in
            DispatchQueue.main.async { [weak self] in
                self?.study = study
                self?.tblView.reloadData()
                self?.studyDescription.text = study.description
                self?.studyIdLabel.text = study.studyId
                self?.studyType.text = study.type
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studyToSerieSegue" {
            if let vc = segue.destination as? SeriesDetailsViewController,
                let selIndex = self.tblView.indexPathForSelectedRow?.row {
                vc.serieId = study.series[selIndex]
            }
        }
    }
}

extension StudyDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return study.series.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = study.series[indexPath.row]
        return cell!
    }
}
