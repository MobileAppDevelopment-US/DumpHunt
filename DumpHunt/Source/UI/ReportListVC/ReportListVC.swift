//
//  ReportListVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class ReportListVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!

    var reports = [Report]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
    }
    
    // Mark: Mehods

    private func configure() {

    }
    
    private func configureTableView() {
        
        tableView.register(UINib(nibName: "ReportListCell", bundle: nil), forCellReuseIdentifier: "ReportListCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource

extension ReportListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportListCell",
                                                 for: indexPath) as! ReportListCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showReportDetailsVC()
    }
    
}


// MARK: - Transition

extension ReportListVC {
    
    private func showReportDetailsVC() {
        
        let loginVCStoryboard = UIStoryboard(name: "ReportDetailsVC", bundle: nil)
        guard let vc = loginVCStoryboard.instantiateViewController(withIdentifier: "ReportDetailsVC") as? ReportDetailsVC else {
            return
        }
        let report = Report(photo: UIImage(named: "hunt.jpg"),
                            fio: "Serik",
                            phone: "90987978979",
                            comment: "Здесь очень грязно",
                            latitude: 64.513695,
                            longitude: 40.507912)
        vc.report = report
        pushViewController(vc)
    }

}


