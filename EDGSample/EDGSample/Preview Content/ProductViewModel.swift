//
//  ProductViewModel.swift
//  EDGSample
//
//  Created by Halcyon Tek on 25/04/23.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    var service = Service.shared
    @Published var products: ProductModel?
    @Published var selectedProducts: [Product] = []
 
    init() {
       fetchProducts()
    }
    func fetchProducts(){
        service.listService { result in
            switch result{
            case .success(let products):
                self.products = products
                print(products)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

