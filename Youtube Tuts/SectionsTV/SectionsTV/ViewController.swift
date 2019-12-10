//
//  ViewController.swift
//  SectionsTV
//
//  Created by Ryan Cummins on 12/3/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  let cellID = "FirstType"
  let names = [
    "Amy", "Bill", "Tom", "Brad", "Karen"
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Contacts"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return names.count
    } else {
      return 1
    }
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    let name = names[indexPath.row]
    if indexPath.section == 0 {
      cell.textLabel?.text = "\(name), Section \(indexPath.section), Row:\(indexPath.row)"
    } else {
      
      cell.textLabel?.text = names[indexPath.row]
    }

    
    
    return cell
  }


}


