//
//  ViewModel.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import Foundation

/// Define type of Catogry
enum CatogryType: String {
    case Polos = "Polos"
    case Sweatshirts = "Sweatshirts"
    case Shirts = "Shirts"
    case Jackets = "Jackets"
    case Sweaters = "Sweaters"
}

/// View model class for bussiness logic , api call and coordination between model and view controller
class ViewModel {
    
    /// Shared instance
    static let shared = ViewModel()
        
    var listOfCategoryModel: [DisplayModel] = []
    
    /// Private struct contain mock api url
    private struct ViewModelConstant {
        static let urlString = "http://demo4308233.mockable.io/all"
    }
    
    /// In this methode call api to get data and set to vairable , also completion handler conatin error messge string
    /// - Parameter completion: Error message string
    func getCategory(completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: ViewModelConstant.urlString) else {
            fatalError("Wrong url string")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                completion("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                completion("Server error!")
                return
            }
            
            do {
                if let data = data  {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([CategoryModel].self, from: data)
                    self.mappingModels(model: model)
                    completion(nil)
                }
            }
            catch let error {
                print("Error creating current weather from JSON because: \(error.localizedDescription)")
                completion(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

extension ViewModel {
    
    /// Mapping json data to Category model
    /// - Parameter model: List of CategoryModel
    func mappingModels(model: [CategoryModel]) {
        let jacket = model.filter({$0.name == CatogryType.Jackets.rawValue})
        let jproduct =  extractProduct(categoryModel: jacket).uniqueValues(value: {$0.sku!})
        if jproduct.count > 0 {
            let model = DisplayModel(name: CatogryType.Jackets.rawValue, products: jproduct)
            listOfCategoryModel.append(model)
        }
        
        let shirt = model.filter({$0.name == CatogryType.Shirts.rawValue})
        let sproduct =  extractProduct(categoryModel: shirt).uniqueValues(value: {$0.sku!})
        if sproduct.count > 0 {
            let model = DisplayModel(name: CatogryType.Shirts.rawValue, products: sproduct)
            listOfCategoryModel.append(model)
        }
        
        let sweatshirts = model.filter({$0.name == CatogryType.Sweatshirts.rawValue})
        let swproduct =  extractProduct(categoryModel: sweatshirts).uniqueValues(value: {$0.sku!})
        if swproduct.count > 0 {
            let model = DisplayModel(name: CatogryType.Sweatshirts.rawValue, products: swproduct)
            listOfCategoryModel.append(model)
        }
        
        let sweaters = model.filter({$0.name == CatogryType.Sweaters.rawValue})
        let sweproduct =  extractProduct(categoryModel: sweaters).uniqueValues(value: {$0.sku!})
        if sweproduct.count > 0 {
            let model = DisplayModel(name: CatogryType.Sweaters.rawValue, products: sweproduct)
            listOfCategoryModel.append(model)
        }
        
        let polos = model.filter({$0.name == CatogryType.Polos.rawValue})
        let pproduct =  extractProduct(categoryModel: polos).uniqueValues(value: {$0.sku!})
        if pproduct.count > 0 {
            let model = DisplayModel(name: CatogryType.Polos.rawValue, products: pproduct)
            listOfCategoryModel.append(model)
        }
    }
    
    /// Return products belong to perticular Category
    /// - Parameter categoryModel: List of CategoryModel
    func extractProduct(categoryModel: [CategoryModel]) -> [Products] {
        var products: [Products] = []
        categoryModel.forEach { (product) in
            product.products?.forEach({ (model) in
                products.append(model)
            })
        }
        return products
    }
}
