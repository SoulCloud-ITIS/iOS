//
//  BookViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 19/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isUserHaveBooks = false
    
    @IBOutlet weak var tableView: UITableView!
    let bookCellIdentifier = "bookCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: bookCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookCellIdentifier, for: indexPath) as! BookTableViewCell
        return cell
    }
    
}
