//
//  EDGSampleTests.swift
//  EDGSampleTests
//
//  Created by Halcyon Tek on 25/04/23.
//

import XCTest
@testable import EDGSample

final class EDGSampleTests: XCTestCase {
    
    let json = """
            {
                "products": [
                    {
                        "citrusId": "123",
                        "title": "Product A",
                        "id": "456",
                        "imageURL": "https://example.com/image.jpg",
                        "price": [
                            {
                                "message": "per bottle",
                                "value": 9.99,
                                "isOfferPrice": true
                            }
                        ],
                        "brand": "Brand A",
                        "badges": ["Sale", "New"],
                        "ratingCount": 4.5,
                        "messages": {
                            "secondaryMessage": "Some message",
                            "sash": {},
                            "promotionalMessage": "Promotion"
                        },
                        "isAddToCartEnable": true,
                        "addToCartButtonText": "Add to cart",
                        "isInTrolley": false,
                        "isInWishlist": false,
                        "purchaseTypes": [
                            {
                                "purchaseType": "Bottle",
                                "displayName": "per bottle",
                                "unitPrice": 9.99,
                                "minQtyLimit": 1,
                                "maxQtyLimit": 10,
                                "cartQty": 0
                            }
                        ],
                        "isFindMeEnable": false,
                        "saleUnitPrice": 8.99,
                        "totalReviewCount": 100,
                        "isDeliveryOnly": false,
                        "isDirectFromSupplier": false
                    }
                ]
            }
            """.data(using: .utf8)!

    
    func testPrice() throws {
            let productModel = try JSONDecoder().decode(ProductModel.self, from: json)
            let product = productModel.products?.first
            XCTAssertEqual(product?.price?.count, 1)
            XCTAssertEqual(product?.price?.first?.message, Message.perBottle)
            XCTAssertEqual(product?.price?.first?.value, 9.99)
            XCTAssertEqual(product?.price?.first?.isOfferPrice, true)
        }

        func testTitle() throws {
            let productModel = try JSONDecoder().decode(ProductModel.self, from: json)
            let product = productModel.products?.first
            XCTAssertEqual(product?.title, "Product A")
        }

        func testImageURL() throws {
            let productModel = try JSONDecoder().decode(ProductModel.self, from: json)
            let product = productModel.products?.first
            XCTAssertEqual(product?.imageURL, "https://example.com/image.jpg")
        }

    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
