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
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
        self.tableView.rowHeight = 100
        registerCell()
    }
    
    //MARK: - Networking
    func getBooks() {
        books.removeAll()
        ApiManager.instance.loadingOfBooks { (currentBooks) in
            for book in currentBooks {
                let newBook = Book(id: book.id, name: book.name, author: book.author, description: book.description, mark: book.mark)
                self.books.append(newBook)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Cells Registration
    
    private func registerCell() {
        let newsCellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(newsCellNib, forCellReuseIdentifier: bookCellIdentifier)
    }
    
    
    //MARK: - Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if !books.isEmpty
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "Вы еще не добавили свои книги"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookCellIdentifier, for: indexPath) as! BookTableViewCell
        let book = books[indexPath.row]
        cell.prepareForReuse()
        cell.prepare(with: book)
        return cell
    }
    
    
    
}
