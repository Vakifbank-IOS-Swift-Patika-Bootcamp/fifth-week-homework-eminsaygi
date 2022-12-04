//
//  WebServices.swift
//  SayMyName
//
//  Created by Emin Saygı on 24.11.2022.
//

import Foundation
import Alamofire


class NetworkManager {
    private let baseURL = "https://breakingbadapi.com/api/"

    static let shared = NetworkManager()
    
    private var session = URLSession.shared

    func fetchCharacters(completion: @escaping(Result<[Character], AFError>) -> Void) {
        AF.request("\(baseURL)characters")
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
    
    
    func getCharacterQuote(author:String,completion:@escaping(_ result:Result<[QuoteModel],ErrorModel>)->Void){
            let endpoint = baseURL + "quote?author=\(author)"
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(.invalidURL))
                return
            }
            let task = session.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                }
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let quotes = try decoder.decode([QuoteModel].self, from: data)
                    completion(.success(quotes))
                }catch{
                    completion(.failure(.invalidData))
                }
            
            }
            task.resume()
        }
    
    
    
    // We used escaping clousere for asynchronous operations. We used escaping clousere in the completion completion block because we need to call it again after processing the model
    //MARK: - This is where we did the data extraction
    func getEpisodesData(completion: @escaping(Result<Episode, Error>)->()){
        
        guard let url = URL(string: "\(baseURL)episodes?series=Breaking+Bad") else {return}
        
        session.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Episode.self, from: data)
                completion(.success(result.self))
                
            }
            catch {
                completion(.failure(error))
                print("Catch")
                
            }
        }
        .resume()
    }



    

}


 
