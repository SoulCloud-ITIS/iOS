//
//  SearchBookTableViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 22/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class SearchBookTableViewController: UITableViewController {

    let bookCellIdentifier = "searchBookCell"
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
       
    }
    
    private func registerCell() {
        let newsCellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(newsCellNib, forCellReuseIdentifier: bookCellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookCellIdentifier, for: indexPath) as! BookTableViewCell
        let book = books[indexPath.row]
        cell.prepareForReuse()
        cell.prepare(with: book)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

extension SearchBookTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        books.removeAll()
        guard let searchBarText = searchController.searchBar.text else { return }
        ApiManager.instance.getBooksByPartOfNameOrAuthor(with: searchBarText) { (currentBooks) in
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
