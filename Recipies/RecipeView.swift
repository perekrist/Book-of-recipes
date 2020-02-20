//
//  RecipeView.swift
//  Recipies
//
//  Created by Перегудова Кристина on 21.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeView: View {
    
    @ObservedObject var obs = Observer()
    @Binding var index : Int
    
    var body: some View {
        VStack {
            ZStack {
                AnimatedImage(url: URL(string: obs.recipes[index].image))
                    .resizable()
                    .frame(width:UIScreen.main.bounds.width, height: 400)
                    .offset(y: -200)
                VStack {
                    Text("Recipe")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(.white)
                        .offset(y: -170)
                }
            }
            
            GeometryReader {geo in
                VStack {
                    Text("\(self.obs.recipes[self.index].label)")
                        .font(.title)
                    Text("\(self.obs.recipes[self.index].calories)")
                    Text("290g protein • 325g fat • 746g carbs")
                    Text("Ingredients:")
                        .bold()
                    ForEach(0 ..< self.obs.recipes[self.index].ingredientLines.count, id: \.self) {
                        Text(self.obs.recipes[self.index].ingredientLines[$0])
                    }
                }
                
            }.background(Color.white)
            .clipShape(Rounded())
            .padding(.top, -275)
        }
    }
}

struct Rounded : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 30, height: 30))
        return Path(path.cgPath)
    }
}
