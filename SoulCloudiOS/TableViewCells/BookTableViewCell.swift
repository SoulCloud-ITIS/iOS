//
//  BookTableViewCell.swift
//  SoulCloudiOS
//
//  Created by Damir Zaripov on 20.03.2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func prepare(with book: Book){
        bookName.text = book.name
        bookAuthor.text = book.author
        bookContent.text = book.description
    }
    
}
