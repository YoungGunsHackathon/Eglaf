//
//  ReportViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

protocol ReportViewControllerDelegate {
    func viewDismissed()
}

class ReportViewController: UIViewController, StoryboardInit {
    
    var userHandler: UserHandler = UserHandler.sharedInstance
    var issueHandler: IssueHandler = IssueHandler.sharedInstance
    var delegate: ReportViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var descriptionField: UITextView!
    
    var issueCategories: [IssueCategory] = [.scanning, .catering, .security, .registration, .infoPoint, .other]
    
    override func viewDidLoad() {
        registerNibs()
        
        prepareNavBar()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        
        let normalTextAttributes: [AnyHashable : Any] = [
            NSAttributedStringKey.foregroundColor as NSObject: UIColor(red:0.35, green:0.43, blue:0.52, alpha:1),
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 10)!
        ]
        
        let boldTextAttributes: [AnyHashable : Any] = [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.font : UIFont(name: "SFProDisplay-Regular", size: 10)!,
            ]
        
        prioritySegment.setTitleTextAttributes(normalTextAttributes, for: .normal)
        prioritySegment.setTitleTextAttributes(boldTextAttributes, for: .selected)
    }
    func prepareNavBar() {
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        //self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationItem.title = "ADD NEW REPORT"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 3
        ]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POST", style: .plain, target: self, action: #selector(post))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 2
            ], for: .normal)
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
    }
    
    @objc func post() {
        guard let path = collectionView.indexPathsForSelectedItems else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        guard let index = path.first?.item else {
            showOKAlert(message: "Please select a category")
            return
        }
        var selectedCategory = issueCategories[index].rawValue.lowercased()
        selectedCategory.removeFirst()
        let isUrgent = prioritySegment.selectedSegmentIndex == 0 ? false : true
        let issue = Issue(description: descriptionField.text, category: selectedCategory, urgent: isUrgent, location: "")
        
        issueHandler.addIssue(issue: issue)
        
        //play anim here kundo
        
        self.dismiss(animated: true, completion: {
            self.delegate?.viewDismissed()
        })
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReportViewController {
    func registerNibs() {
        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
}


extension ReportViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 17, 0, 17)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 99, height: 46)
    }
}

extension ReportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ReportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.categoryType = issueCategories[indexPath.row]
        return cell
    }
}
