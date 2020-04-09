//
//  SettingsVC.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/3/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    let tableView  = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Settings"
        navigationController?.isNavigationBarHidden = false
        configureViewController()
        configureScrollView()
        // Do any additional setup after loading the view.
    }
    
    func configureViewController() {
        tableView.delegate      = self
        tableView.dataSource    = self
        
    }
    
    @objc func dismissVC() {
           dismiss(animated: true)
       }
    
    func configureScrollView() {
        view.addSubview(tableView)
     tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
    

}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

}
