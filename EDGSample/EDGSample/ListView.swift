//
//  ListView.swift
//  EDGSample
//
//  Created by Halcyon Tek on 25/04/23.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var productViewModel = ProductViewModel()
    @State private var isShowingDetail = false
    @State private var selectedProduct: Product?
    
    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Color.clear
                        .ignoresSafeArea()
                    List {
                        if #available(iOS 15.0, *) {
                            ForEach (productViewModel.products?.products ?? [Product]()) { product in
                                ListItem(name: product.title ?? "",imageUrl: product.imageURL ?? "",price: "\(product.price?.first?.value ?? 0.0)", isFavourite: product.isFavorite, product: product, id: product.id, favoriteView: false )
                                    .listRowBackground(Color.blue)
                                    .onTapGesture {
                                        isShowingDetail = true
                                        selectedProduct = product
                                    }}
                            .listRowSeparator(.hidden) // Hide the default separator
                        } else {
                            // Fallback on earlier versions
                        }}
                    
                    NavigationLink(
                        destination: ProductDetailView(product: selectedProduct, rating: Int(selectedProduct?.ratingCount ?? 0.0)),
                        isActive: $isShowingDetail
                    ) {
                    }
                    .hidden()
                    .navigationBarTitle("Product Details")
                }}
            
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Product List")
            }
            NavigationView {
                List {
                    if #available(iOS 15.0, *) {
                        
                        ForEach (productViewModel.favoriteProducts) { product in
                            ListItem(name: product.title ?? "",imageUrl: product.imageURL ?? "",price: "\(product.price?.first?.value ?? 0.0)", isFavourite: product.isFavorite , product: product, id: product.id, favoriteView: true)
                                .listRowBackground(Color.blue)
                        }
                        .listRowSeparator(.hidden) // Hide the default separator
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }}
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favourite Products")
            }}
        .environmentObject(productViewModel)
    }
}


//MARK: -  Product Details View
struct ProductDetailView: View {
    let product: Product?
    
    @State private var isFavourite = false
    let rating:Int
    var body: some View {
        VStack {
            if let product = product {
                if let imageUrl = product.imageURL,
                   let url = URL(string: imageUrl),
                   let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                }
                
                Text(product.title ?? "N/A")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.top)
                
                Text("\(product.price?.first?.value ?? 0.0)")
                    .font(.title)
                    .padding(.bottom)
                HStack{
                    ForEach(0 ..< rating, id: \.self) { index in    // – NOT STABLE
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }}
                
                Button(action: {
                    isFavourite.toggle()
                }) {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(isFavourite ? .red : .black)
                }}}
        .padding(.top)
        .background(Color.green)
    }
}

//MARK: - List View Preview
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }}

//MARK: -  Product List View
struct ListItem: View {
    var name:String
    var imageUrl:String
    var price:String
    @State var isFavourite:Bool
    var product: Product
    var id:String
    var favoriteView:Bool
    @EnvironmentObject  var productViewModel: ProductViewModel
    
    
    var body: some View {
        HStack {
            if #available(iOS 15.0, *) {
                AsyncImage(
                    url: URL(string: imageUrl),
                    
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }, placeholder: {
                        Color.clear
                    })
                .frame(width: 50, height: 50)
                .offset(x: -10)
                .background(Color.clear)
            } else {
                // Fallback on earlier versions
            }
            VStack(alignment:.leading){
                Text(name)
                    .fontWeight(.semibold)
                    .font(.title3)
                Text(price)
                    .fontWeight(.medium)
                    .font(.subheadline)
            }
            Spacer() 
            if favoriteView{
                Image(systemName: "xmark.bin.fill")
                    .foregroundColor(.red)
                    .onTapGesture {
                        if let index = productViewModel.products?.products?.firstIndex(where: {$0.id == id}){
                            productViewModel.products?.products?[index].isFavorite = false
                            productViewModel.removeItem(id: id)
                            print(productViewModel.products?.products?[index])
                        }}
            }else{
                Image(systemName: "cart")
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                
                    .onTapGesture {
                        isFavourite.toggle()
                        
                        if isFavourite{
                            if let index = productViewModel.products?.products?.firstIndex(where: {$0.id == id}){
                                productViewModel.products?.products?[index].isFavorite = true
                                guard let product  = productViewModel.products?.products?[index] else {return}
                                productViewModel.addItemToFavorite(product: product)
                            }
                        }else{
                            productViewModel.removeItem(id: id)
                        }}
            }}
        .foregroundColor(.black)
        .padding(.horizontal,0)
    }
}

