//
//  SelectGenresViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 20/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import BEMCheckBox

struct Genre {
    let id: Int
    let name: String
    var isSelected: Bool
}

class SelectGenresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var genresArray: [Genre] = [Genre(id: 1, name: "love", isSelected: false), Genre(id: 2, name: "fantastic", isSelected: false), Genre(id: 3, name: "fantasy", isSelected: false), Genre(id: 4, name: "detective", isSelected: false), Genre(id: 5, name: "adventure", isSelected: false), Genre(id: 6, name: "art", isSelected: false)]
    var alertFactory: AlertFactoryProtocol?
    let errorTitle = "Ошибка"
    let errorMessage = "Выберите минимум 2 жанра"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertFactory = AlertFactory()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        showAnimate()

    }
    
    //MARK: - ConfirmButton
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        
        var count: Int = 0
        genresArray.forEach { (genre) in
            if genre.isSelected {
                count = count + 1
            }
        }
        
        if count < 2 {
            let alert = alertFactory?.getAlert(with: errorTitle, and: errorMessage)
            self.present(alert!, animated: true, completion: nil)
        } else {
            genresArray.forEach { (genre) in
                if genre.isSelected {
                    ApiManager.instance.addGenreToUser(with: genre.id, completionBlock: { (error, message, success) in
                        print(message)
                        print(success)
                        print("--------")
                    })
                }
            }
            self.view.removeFromSuperview()
        }
    }
    
    //MARK: - Animations
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }) { (finished: Bool) in
            if finished {
                self.view.removeFromSuperview()
            }
        }
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GenresTableViewCell

        cell.textLabel?.text = genresArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! GenresTableViewCell
        if cell.checkBox.on == false {
            cell.checkBox.setOn(true, animated: true)
            genresArray[indexPath.row].isSelected = true
            print(genresArray[indexPath.row].name,  genresArray[indexPath.row].isSelected)
        } else {
            cell.checkBox.setOn(false, animated: true)
            genresArray[indexPath.row].isSelected = false
            print(genresArray[indexPath.row].name,  genresArray[indexPath.row].isSelected)
        }
    }
}
