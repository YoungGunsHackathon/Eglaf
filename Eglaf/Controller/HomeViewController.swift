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
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var userHandler: UserHandler = UserHandler.sharedInstance
    var issueHandler: IssueHandler = IssueHandler.sharedInstance
    var issues: [Issue] = []
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        issueHandler.observeIssues { (issuesFetched) in
            self.issues = []
            for issue in issuesFetched {
                self.issues.append(issue)
            }
            self.tableView.reloadData()
        }
        
        prepareUI()
        registerXibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      
        
    }
}

//MARK: - HomeViewController (UI)

extension HomeViewController {
    func prepareUI() {
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationItem.title = "DASHBOARD"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 4
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ALL", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor(red:0.35, green:0.43, blue:0.52, alpha:1),
            NSAttributedStringKey.kern: 2
            ], for: .normal)
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
        return issues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell") as? IssueTableViewCell else {
            return UITableViewCell()
        }
        
        if let creator = issues[indexPath.row].creator {
            userHandler.getUser(userId: creator) { (user) in
                if let profileUrl = user.pictureUrl {
                    cell.profileImageView.loadImageWithURL(urlString: profileUrl)
                }
                
                if let firstname = user.firstName {
                    cell.nameLabel.text = firstname
                }
                
                if let lastname = user.lastname {
                    cell.nameLabel.text?.append(" " + lastname)
                }
            }
        }
        
        if let description = issues[indexPath.row].description {
            cell.issueTextLabel.text = description
        }
        
        if let timestamp = issues[indexPath.row].createdTime {
            let minutes: Int = Utils.getMinutes(timestamp: timestamp)
            cell.timeLabel.text = minutes > 0 ? "\(minutes) minutes ago" : "less than minute ago"
        }
        
        if let category = issues[indexPath.row].category {
            cell.categoryLabel.text = category
        }
        
        
        
        return cell
    }
}
