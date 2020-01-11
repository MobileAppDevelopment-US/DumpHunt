//
//  ConfirmationVC.swift
//  DumpHunt
//
//  Created by Serik on 07.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class ConfirmationVC: BaseVC {
    
    // MARK: - Outlets

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var imageViewCheckTermsOfService: UIImageView!
    @IBOutlet weak var imageViewCheckPrivacyPolicy: UIImageView!
    @IBOutlet weak var viewCheckTermsOfService: UIView!
    @IBOutlet weak var viewCheckPrivacyPolicy: UIView!
    
    var isCheckTermsOfServicy = false
    var isCheckPrivacyPolicy = false
    var isActiveEnterButton: Bool = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        notSelectedPostReportButton(enterButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
    }
    
    private func configure() {
        
        iconImageView.layer.cornerRadius = 10.0
        iconImageView.layer.masksToBounds = true
        
        enterButton.layer.cornerRadius = enterButton.frame.size.height / 2
        enterButton.layer.masksToBounds = true
        
        createTapGestureRecognizers()
        
        imageViewCheckTermsOfService.isHidden = !isCheckTermsOfServicy
        imageViewCheckPrivacyPolicy.isHidden = !isCheckPrivacyPolicy
        
        viewCheckTermsOfService.layer.borderColor = Design.grayText.cgColor
        viewCheckTermsOfService.layer.borderWidth = 1
        viewCheckTermsOfService.layer.cornerRadius = 4
        viewCheckTermsOfService.layer.masksToBounds = true
        
        viewCheckPrivacyPolicy.layer.borderColor = Design.grayText.cgColor
        viewCheckPrivacyPolicy.layer.borderWidth = 1
        viewCheckPrivacyPolicy.layer.cornerRadius = 4
        viewCheckPrivacyPolicy.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    
    @IBAction func enterActionButton(_ sender: UIButton) {
   
        UserDefaults.standard.set(true, forKey: Design.notFirstEnter)
        showCreateReportVC()
    }
    
    @IBAction func privacyPolicyActionButton(_ sender: UIButton) {
        showPrivacyPolicyOrTermsOfService(DesignModel.PrivacyPolicy)
    }
    
    @IBAction func termsOfServiceButtonActionButton(_ sender: UIButton) {
        showPrivacyPolicyOrTermsOfService(DesignModel.TermsOfService)
    }
    
    private func createTapGestureRecognizers() {
        
        let termsOfServiceTapGesture = UITapGestureRecognizer(target: self, action: #selector(checkTermsOfService))
        viewCheckTermsOfService.isUserInteractionEnabled = true
        viewCheckTermsOfService.addGestureRecognizer(termsOfServiceTapGesture)
        
        let privacyPolicyTapGesture = UITapGestureRecognizer(target: self, action: #selector(checkPrivacyPolicy))
        viewCheckPrivacyPolicy.isUserInteractionEnabled = true
        viewCheckPrivacyPolicy.addGestureRecognizer(privacyPolicyTapGesture)
    }
    
    @objc private func checkTermsOfService() {
        
        isCheckTermsOfServicy = isCheckTermsOfServicy == false ? true : false
        imageViewCheckTermsOfService.isHidden = !isCheckTermsOfServicy
        hideGetStartedButton()
    }
    
    @objc private func checkPrivacyPolicy() {
        
        isCheckPrivacyPolicy = isCheckPrivacyPolicy == false ? true : false
        imageViewCheckPrivacyPolicy.isHidden = !isCheckPrivacyPolicy
        hideGetStartedButton()
    }
    
    private func hideGetStartedButton() {
        
        if isCheckTermsOfServicy && isCheckPrivacyPolicy {
            if isActiveEnterButton { return }
            selectedPostReportButton(enterButton)
            isActiveEnterButton = true
        } else {
            if !isActiveEnterButton { return }
            notSelectedPostReportButton(enterButton)
            isActiveEnterButton = false
        }
    }
    
}

// MARK: - Show PrivacyPolicy or TermsOfService

extension ConfirmationVC {
    
    func showPrivacyPolicyOrTermsOfService(_ sitePath: String) {
        
        if let url = URL(string: sitePath), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}

// MARK: - Transition

extension ConfirmationVC {
    
    private func showCreateReportVC() {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "TabBarVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        appdelegate.window!.rootViewController = vc
    }
    
}


