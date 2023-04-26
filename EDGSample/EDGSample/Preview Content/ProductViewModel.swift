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
    @Published var favoriteProducts:[Product] = []

 
    
    init() {
       fetchProducts()
    }
    
    
    
    //MARK: -  To fetch product list
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
    
    
    
    //MARK: -  To add Favourite items
    func addItemToFavorite(product:Product){
        favoriteProducts.append(product)
        print(favoriteProducts)
    }
    
    
    
    //MARK: -  To remove Favourite items
    func removeItem(id:String){
        if let index = favoriteProducts.firstIndex(where: {$0.id == id}){
            favoriteProducts.remove(at: index)
        }}
    
}

