//
//  HomeViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, StoryboardInit {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        prepareUI()
        registerXibs()
    }
}

//MARK: - HomeViewController (UI)

extension HomeViewController {
    func prepareUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func registerXibs() {
        tableView.register(UINib(nibName: "IssueTableViewCell", bundle: nil), forCellReuseIdentifier: "IssueTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell") as! IssueTableViewCell
        return cell
    }
}
