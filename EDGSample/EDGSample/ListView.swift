//
//  ListView.swift
//  EDGSample
//
//  Created by Halcyon Tek on 25/04/23.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var productViewModel = ProductViewModel()
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
                                       ListItem(name: product.title ?? "",imageUrl: product.imageURL ?? "",price: "\(product.price?.first?.value ?? 0.0)" )
                                           .listRowBackground(Color.blue)
                                           .onTapGesture {
                                               isShowingDetail = true
                                               selectedProduct = product
                                           }}
                                   .listRowSeparator(.hidden) // Hide the default separator
                                   
                               } else {
                                   // Fallback on earlier versions
                               }
                           }
                           .padding()
                           NavigationLink(
                               destination: ProductDetailView(product: selectedProduct),
                               isActive: $isShowingDetail
                           ) {
                               EmptyView()
                           }
                           .hidden()
                           .navigationBarTitle("Product Details")
                       }}
                   .tabItem {
                       Image(systemName: "list.bullet")
                       Text("Product List")
                   }
                   
                   NavigationView {
                       ZStack {
                           Color.green
                               .ignoresSafeArea()
                           Text("Favourite products")
                               .font(.largeTitle)
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                       }}
                   .tabItem {
                       Image(systemName: "heart.fill")
                       Text("Favourite Products")
                   }
               }
           }
       }
    
struct ProductDetailView: View {
    let product: Product?
    
    @State private var isFavourite = false
    
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
                
                Button(action: {
                    isFavourite.toggle()
                }) {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(isFavourite ? .red : .black)
                }
            }
        }
        .padding(.top)
        .background(Color.green)
    }
}


    
    struct ListView_Previews: PreviewProvider {
        static var previews: some View {
            ListView()
        }}
    
    struct ListItem: View {
        var name:String
        var imageUrl:String
        var price:String
        @State var isFavourite: Bool = false
        @ObservedObject var productViewModel = ProductViewModel()

        
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
                Image(systemName: "cart")
                
                    .onTapGesture {
                        print("")
                        
                    }
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                
                    .onTapGesture {
                        isFavourite.toggle()
                    }}
            .foregroundColor(.black)
            .padding(.horizontal,0)
        }
    }

