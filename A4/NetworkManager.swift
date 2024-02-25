//
//  NetworkManager.swift
//
//  Created by Jamayne Gyimah-Danquah on 11/12/23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){
        
        
    }
    let decoder = JSONDecoder()
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        let endpoint = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        var fetchedRecipes : [Recipe] = []
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder){ response in
                switch response.result{
                case .success(let AllRecipes):
                    print(AllRecipes)
                    completion(AllRecipes)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRecipes:\(error.localizedDescription)")
                    completion([])
                }
            }
        
    }
}
