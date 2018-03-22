//
//  ApiManager.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 18/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let instance = ApiManager()
    var userToken: String = ""
    
    func registerNewUser(with email: String, and password: String, completionBlock: @escaping (Bool) -> ()) {
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/registration") else { return }
        let parametrs = ["email": "\(email)", "password": "\(password)"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let httpBody = "email=\(email)&password=\(password)"
        request.httpBody = httpBody.data(using: .utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                 guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                if let answerStatus = json["success"] as? Bool {
                    completionBlock(answerStatus)
                    print(answerStatus)
                }
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func loginUser(with email: String, and password: String, completionBlock: @escaping (String,Bool) -> ()) {
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-type")
        let httpBody = "email=\(email)&password=\(password)"
        request.httpBody = httpBody.data(using: .utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    guard let answerStatus = json["success"] as? Bool else { return }
                    guard let token = json["message"] as? String else { return }
                    print(token)
                    completionBlock(token, answerStatus)
    
                    print(json)
                } catch let errorMessage2 {
                    print(errorMessage2.localizedDescription)
                }
            }.resume()
        }
    
    func loadingOfBooks(comlitionBlock: @escaping ([Book]) -> ()){
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/books/\(userToken)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
    
            if  (error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                do {
                    let booksDictionary = try JSONDecoder().decode([Book].self, from: data)
                    print("Data \(String(describing: booksDictionary))")
                    comlitionBlock(booksDictionary)
                } catch let errorMessage {
                     print(errorMessage.localizedDescription)
                }
                
            }
        }.resume()
    }
        
    func addGenreToUser(with genreId: Int, completionBlock: @escaping (Int,String,Bool) -> ()) {
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/genres/\(genreId)/\(userToken)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                guard let answerStatus = json["success"] as? Bool else { return }
                guard let message = json["message"] as? String else { return }
                guard let error = json["error_code"] as? Int else { return }
                completionBlock(error, message, answerStatus)
                
                print(json)
            } catch let errorMessage2 {
                print(errorMessage2.localizedDescription)
            }
            }.resume()
        }
    
    func getRecomendedBookByGenres(comlitionBlock: @escaping ([Book]) -> ()){
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/books/genres/recommend/1/\(userToken)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if  (error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                do {
                    let booksDictionary = try JSONDecoder().decode([Book].self, from: data)
                    print("Data \(String(describing: booksDictionary))")
                    comlitionBlock(booksDictionary)
                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
                
            }
        }.resume()
    }
    
    func getRecomendedBookByAI(completionBlock: @escaping ([Book]) -> ()) {
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/books/recommended/\(userToken)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if  (error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                do {
                    let booksDictionary = try JSONDecoder().decode([Book].self, from: data)
                    print("Data \(String(describing: booksDictionary))")
                    completionBlock(booksDictionary)
                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
                
            }
        }.resume()
    }
    
    func checkUsersBook(completionBlock: @escaping (Bool) -> ()) {
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/books/\(userToken)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if  (error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                do {
                    let booksDictionary = try JSONDecoder().decode([Book].self, from: data)
                    print("Data \(String(describing: booksDictionary))")
                    if booksDictionary.isEmpty {
                        completionBlock(false)
                    } else {
                        completionBlock(true)
                    }
                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getAllBooks(from page: Int, and comlitionBlock: @escaping ([Book]) -> ()){
        guard let url = URL(string: "https://soul-cloud-api.herokuapp.com/books/\(page)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if  (error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                do {
                    let booksDictionary = try JSONDecoder().decode([Book].self, from: data)
                    print("Data \(String(describing: booksDictionary))")
                    comlitionBlock(booksDictionary)
                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
                
            }
            }.resume()
    }
    
    func getBooksByPartOfNameOrAuthor(with partOfBook: String, comlitionBlock: @escaping ([Book]) -> ()){
        
        let baseUrl : String = "https://soul-cloud-api.herokuapp.com/books/search/1/"
        let  name : String = partOfBook
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let finalUrl = baseUrl + encodedName!
        
        guard let url = URL(string: finalUrl) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if  (error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                do {
                    let booksDictionary = try JSONDecoder().decode([Book].self, from: data)
                    print("Data \(String(describing: booksDictionary))")
                    comlitionBlock(booksDictionary)
                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
                
            }
            }.resume()
    }
    
    
}
