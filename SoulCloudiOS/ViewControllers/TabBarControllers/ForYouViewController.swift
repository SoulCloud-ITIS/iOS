//
//  ForYouViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 19/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class ForYouViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    let bookCellIdentifier = "recomendationCell"
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getBookByGenres()
    }
    
    func getBookByGenres() {
        books.removeAll()
        ApiManager.instance.getRecomendedBookByGenres { (currentBooks) in
            for book in currentBooks {
                let newBook = Book(id: book.id, name: book.name, author: book.author, description: book.description, mark: book.mark, url: book.url)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookCellIdentifier, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
