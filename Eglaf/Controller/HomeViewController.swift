//
//  HomeViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import Lottie

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
            
            self.issues = self.issues.sorted {
                Int($0.createdTime!)! > Int($1.createdTime!)!
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .plain, target: self, action: #selector(showReportScreen))
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ALL", style: .plain, target: self, action: #selector(showFilterScreen))
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor(red:0.35, green:0.43, blue:0.52, alpha:1),
            NSAttributedStringKey.kern: 2
            ], for: .normal)
    }
    @objc func showReportScreen() {
        let vc = ReportViewController.storyboardInit()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    @objc func showFilterScreen() {
        let vc = FilterViewController.storyboardInit()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
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
            let string = "#\(category.uppercased())"
            guard let categoryIssue = IssueCategory(rawValue: string) else {
                cell.categoryLabel.text = "Unknown"
                return cell
            }
            cell.categoryLabel.text = categoryIssue.rawValue
            cell.categoryLabel.textColor = categoryIssue.categoryColor
            cell.tagView.layer.borderColor = categoryIssue.categoryColor.cgColor
        }
        
        return cell
    }
}

extension HomeViewController: ReportViewControllerDelegate {
    func viewDismissed() {
        tableView.alpha = 0.1
        let animationView = LOTAnimationView(name: "checked_done_")
        animationView.loopAnimation = false
        self.view.addSubview(animationView)
        self.view.bringSubview(toFront: animationView)
        animationView.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height / 2.0)
        animationView.play { (completion) in
            UIView.transition(with: self.view, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                animationView.removeFromSuperview()
                self.tableView.alpha = 1.0
            }, completion: nil)
        }
    }
}
