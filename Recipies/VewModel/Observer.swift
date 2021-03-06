//
//  Observer.swift
//  Recipies
//
//  Created by Перегудова Кристина on 20.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Observer: ObservableObject {
    private var timer: Timer?
    @Published var recipes = [RecipeModel]()
    @Published var query = "" {
        didSet {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
//                if self.diet != "" {
//                    self.dietType = "&diet=" + self.diet
//                } else {
//                    self.dietType = ""
//                }
                self.request(query: self.query)
            })
        }
    }
    
    @Published var diet = ""
    
    var dietType = ""
    
    var baseURL = "https://api.edamam.com/search?app_id=01566945&app_key=31cab974f44572161ae3fed79767c869"
    
    func request (query: String) {
        recipes.removeAll()
        var newQuery = ""
        for i in query {
            if i == " " {
                newQuery.append("+")
            } else {
                newQuery.append(i)
            }
        }
        let url = baseURL + "&q=\(newQuery)" + dietType
        AF.request(url).responseData { (data) in
            let json = try! JSON(data: data.data!)
            let hits = json["hits"]
            var id = 0
            for i in hits {
                let rec = i.1["recipe"]
                let recipe = RecipeModel(id: id, label: rec["label"].stringValue, image: rec["image"].stringValue, calories: rec["calories"].intValue, ingredientLines: rec["ingredientLines"].arrayObject as! [String])
                self.recipes.append(recipe)
                id += 1
            }
        }
    }
}
