//
//  ReportListVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

final class ReportListVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var reports = [Report]()
    var isGetReports: Bool = true
    var refreshControl: UIRefreshControl!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addRefreshControl()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
        checkConnectedToInternet()
        if isGetReports { // when returning from ReportDetailsVC do not load reports
            getReports()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)

        isGetReports  = true
    }
    
    // Mark: Methods
    
    private func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self,
                                 action: #selector(getReports),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func configureTableView() {
        
        tableView.register(UINib(nibName: ReportListCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ReportListCell.identifier)
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
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportListCell.identifier,
                                                 for: indexPath) as! ReportListCell
        let report = reports[indexPath.row]
        cell.setReport(report)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showReportDetailsVC(indexPath: indexPath)
    }
    
}

// MARK: - Transition

extension ReportListVC {
    
    private func showReportDetailsVC(indexPath: IndexPath) {
        
        guard let vc = ReportDetailsVC.instanceFromStoryboard(.reportDetailsVC) as? ReportDetailsVC else { return }
        vc.delegate = self
        vc.report = reports[indexPath.row]
        pushViewController(vc)
    }

}

// MARK: - NetworkClient

extension ReportListVC {
    
    @objc private func getReports() {
        
        if networkClient.isConnectedToInternet == false {
            self.refreshControl.endRefreshing()
            return
        }
        
        if refreshControl.isRefreshing == false {
            showSpinner()
        }
        
        networkClient.getReports(success: { [weak self] (reportsData) in
            guard let self = self else { return }
            self.reports = reportsData.results
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.hideSpinner()
                self.tableView.reloadData()
            }
            },
                                 failure:
            { [weak self] (message) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.hideSpinner()
                    self.showError(message)
                }
        })
    }
    
    func showError(_ message: String?) {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.ok,
                                      style: .default,
                                      handler: { _ in
                                        if self.refreshControl.isRefreshing == true {
                                            self.refreshControl.endRefreshing()
                                        }
        }))
        self.present(alert, animated: true)
    }
    
}

// MARK: - ReportListVCDelegate

extension ReportListVC: ReportListVCDelegate {
    
    func setIsGetReports(_ isGetReports: Bool) {
        self.isGetReports = isGetReports
    }
    
}
