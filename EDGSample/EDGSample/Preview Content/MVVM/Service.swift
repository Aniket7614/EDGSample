//
//  Service.swift
//  EDGSample
//
//  Created by Halcyon Tek on 25/04/23.
//

import Foundation

class Service{
    
    static let shared = Service()
    
    //MARK: - List Service
    func listService(completion: @escaping (Result<ProductModel,NetworkError>)->Void){
        
        ApiHandler.getParse(urlString: "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328", parameters: nil, headers: nil, method: .get) { (result:Result<Data,NetworkError>) in
            
            switch result{
            case .success(let success):
                do{
                    let userModel = try JSONDecoder().decode(ProductModel.self, from: success)
                    completion(.success(userModel))
                }catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(.error(message: error.localizedString )))
            }
            
        }
    }
    
}

