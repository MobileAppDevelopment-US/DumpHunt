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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
    }
    
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
        return 20//users.count
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
        
        pushViewController(vc)
    }
    
}


