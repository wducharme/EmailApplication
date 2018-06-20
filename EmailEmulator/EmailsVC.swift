//
//  EmailsVC.swift
//  Webscrape Tutorial
//
//  Created by Will Ducharme on 6/14/18.
//  Copyright © 2018 DuCharme. All rights reserved.
//

import UIKit

class EmailsVC: UIViewController {
    
    var emails: [Email]!
    
}

extension EmailsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = emails[indexPath.row].author
        cell.detailTextLabel?.text = emails[indexPath.row].title
        return cell
    }
}

