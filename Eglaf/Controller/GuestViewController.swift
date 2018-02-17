//
//  GuesViewController.swift
//  Eglaf
//
//  Created by Adam Zvada on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController, StoryboardInit {

    @IBOutlet weak var tableView: UITableView!
    
    var tickets: [Ticket] = []
    
    let apiEvent = EventAPIService(network: Network(), authHandler: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        UIShit()
        
        tableView.register(UINib(nibName: "GuestTableViewCell", bundle: nil), forCellReuseIdentifier: "GuestTableViewCell")
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateGuests()
    }
    
    func UIShit() {
        self.tableView.sectionIndexColor = UIColor.clear
        self.tableView.separatorColor = UIColor.lightGray
        
        self.tableView.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        //self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationItem.title = "CHECKED IN"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 4
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(quit))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
    }
    
    @objc func quit() {
        self.dismiss(animated: true, completion: nil)
    }
    

    func updateGuests() {
        apiEvent.getTickets(eventId: "cc6c6fad-8047-4084-9aca-d7be1ee06c92eve").startWithResult { (result) in
            if case .success(let value) = result {
                if let data = value {
                    for ticket in data.tickets {
                        if let _ = ticket.checkedAt {
                            self.tickets.append(ticket)
                        }
                    }
                    self.tableView.reloadData()
                } else {
                    print("--- No Data ----")
                }
            }
            
            if case .failure(let error) = result {
                //self.state = .error
                print(error)
            }
        }
    }
}

extension GuestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension GuestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GuestTableViewCell") as? GuestTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        cell.name.text = tickets[indexPath.row].name
        
        //cell.time.text = tickets[indexPath.row].checkedAt
        if let date = Formatter.iso8601.date(from: tickets[indexPath.row].checkedAt!)  {
            let minutesAgo: Int = Utils.getMinutes(timestamp: String(format: "%.0f", date.timeIntervalSince1970))
            

            cell.time.text = minutesAgo < 0 ?
                "less than minute" : minutesAgo > 60 ?
                Int(minutesAgo/60) < 1 ? "\(Int(minutesAgo/60)) hours ago" : "\(Int(minutesAgo/60)) hour ago"  : "\(minutesAgo) minutes ago"
            
        }
        
//        if let creator = issues[indexPath.row].creator {
//            userHandler.getUser(userId: creator) { (user) in
//                if let profileUrl = user.pictureUrl {
//                    cell.profileImageView.loadImageWithURL(urlString: profileUrl)
//                }
//                
//                if let firstname = user.firstName {
//                    cell.nameLabel.text = firstname
//                }
//                
//                if let lastname = user.lastname {
//                    cell.nameLabel.text?.append(" " + lastname)
//                }
//            }
//        }
//        
//        if let description = issues[indexPath.row].description {
//            cell.issueTextLabel.text = description
//        }
//        
//        if let timestamp = issues[indexPath.row].createdTime {
//            let minutes: Int = Utils.getMinutes(timestamp: timestamp)
//            cell.timeLabel.text = minutes > 0 ? "\(minutes) minutes ago" : "less than minute ago"
//        }
//        
//        if let category = issues[indexPath.row].category {
//            cell.categoryLabel.text = category
//        }
//        
        
        
        return cell
    }
}
