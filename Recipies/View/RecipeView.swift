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
                Text("Recipe")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .offset(y: -130)
            }
            
            GeometryReader { geo in
                VStack {
                    Text("\(self.obs.recipes[self.index].label)")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .padding()
                    Text("\(self.obs.recipes[self.index].calories) kcal")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    Text("290g protein • 325g fat • 746g carbs")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    Text("Ingredients:")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    ForEach(0 ..< self.obs.recipes[self.index].ingredientLines.count, id: \.self) {
                        Text(self.obs.recipes[self.index].ingredientLines[$0])
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }.background(Color.white)
            .clipShape(Rounded())
            .padding(.top, -250)
        }
    }
}
