//
//  ForYouViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 19/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class ForYouViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ButtonTappedDelegate {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let bookCellIdentifier = "recomendationCell"
    var books = [Book]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
        registerCell()
        getBooks()
    }
    
    func getBooks() {
        ApiManager.instance.checkUsersBook { (isAddedBooks) in
            if isAddedBooks == false {
                self.getRecomendedBookByGenres()
            } else {
                self.getRecomendedBookByAI()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getRecomendedBookByGenres() {
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
    
    func getRecomendedBookByAI() {
        books.removeAll()
        ApiManager.instance.getRecomendedBookByAI { (currentBooks) in
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if !books.isEmpty
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        } else {
            
            let test = backgroundView as! TableBackgroundUIView
            test.delegate = self
            tableView.backgroundView = test
            tableView.separatorStyle = .none
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK - Button Delegate
    
    func didTapButton() {
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! SelectGenresViewController
        self.addChildViewController(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParentViewController: self)
        getRecomendedBookByGenres()
    }
    
    //MARK - Action for pull to refresh
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        getBooks()
        refreshControl.endRefreshing()
    }
}
