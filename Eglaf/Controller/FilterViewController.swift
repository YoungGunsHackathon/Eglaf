//
//  FilterViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: UIViewController, StoryboardInit {
    @IBOutlet weak var tableView: UITableView!
    var issueCategories: [IssueCategory] = [.scanning, .catering, .security, .registration, .infoPoint, .other]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavBar()
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func prepareNavBar() {
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        //self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationItem.title = "SELECT CATEGORY"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 4
        ]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SELECT", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 2
            ], for: .normal)
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return issueCategories.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.categoryType = issueCategories[indexPath.section]
        cell.selectionStyle = .none
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
