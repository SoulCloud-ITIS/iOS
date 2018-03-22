//
//  NewViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 19/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let bookCellIdentifier = "allBooksCell"
    var books = [Book]()
    var pageCount = 1
  
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getBooks()
        
    }
    
    func getBooks() {
        ApiManager.instance.getAllBooks(from: pageCount) { (currentBooks) in
            if currentBooks.isEmpty {
                return
            } else {
                for book in currentBooks {
                    let newBook = Book(id: book.id, name: book.name, author: book.author, description: book.description, mark: book.mark, url: book.url)
                    self.books.append(newBook)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Cells Registration
    
    private func registerCell() {
        let newsCellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(newsCellNib, forCellReuseIdentifier: bookCellIdentifier)
    }

    
    //MARK: - Table View Methods
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == books.count - 1 {
            pageCount += 1
            getBooks()
        }
    }

}
