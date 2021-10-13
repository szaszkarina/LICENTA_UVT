//
//  StudyDetailsViewController.swift
//  MVVM_Example
//
//  Created by Szasz Karina on 23/04/2020.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class StudyDetailsViewController:  UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var studyDescription: UILabel!
    @IBOutlet weak var studyId: UILabel!
    @IBOutlet weak var studyType: UILabel!
    
    var viewModel: StudyDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.tableFooterView = UIView()
        
        viewModel?.getDataFromAPI(url: EndPoint.strUrlStudy) { () in
            DispatchQueue.main.async { [weak self] in
                self?.tblView.reloadData()
                self?.studyDescription.text = self?.viewModel?.getDescription()
                self?.studyId.text = self?.viewModel?.getStudyId()
                self?.studyType.text = self?.viewModel?.getType()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studyToSerieSegue" {
            if let vc = segue.destination as? SeriesDetailsViewController,
                let selIndex = self.tblView.indexPathForSelectedRow?.row {
                vc.viewModel = SeriesDetailsViewModel(id: viewModel?.getCellData(index: selIndex) ?? "")
            }
        }
    }
}

extension StudyDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
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
