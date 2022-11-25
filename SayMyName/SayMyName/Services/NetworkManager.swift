//
//  WebServices.swift
//  SayMyName
//
//  Created by Emin Saygı on 24.11.2022.
//

import Foundation
import Alamofire

let charactersUrl = "https://www.breakingbadapi.com/api/characters"

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacters(from url: String, completion: @escaping(Result<[Character], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let charaters = Character.getCharacters(from: value)
                    completion(.success(charaters))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}





/*
 class WebServices {
     static let shared = WebServices()
     private var session = URLSession.shared
     
     // We used escaping clousere for asynchronous operations. We used escaping clousere in the completion completion block because we need to call it again after processing the model
     //MARK: - This is where we did the data extraction
     func getQuotesData(completion: @escaping(Result<Welcome, Error>)->()){
         
         guard let url = URL(string: "https://breakingbadapi.com/api/characters") else {return}
         
         session.dataTask(with: URLRequest(url: url)) { data, _, error in
             guard let data = data, error == nil else {
                 return
             }
             do {
                 let result = try JSONDecoder().decode(Welcome.self, from: data)
                 completion(.success(result.self))
                 //print(result)
                 
             }
             catch {
                 completion(.failure(error))
                 print("Catch: WebService.swift : getQuotes")
                 
             }
         }
         .resume()
     }

 }

 */
