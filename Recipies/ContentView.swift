//
//  ContentView.swift
//  Recipies
//
//  Created by Перегудова Кристина on 20.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var view = 0
    @State var size = UIScreen.main.bounds.width / 1.6
    @ObservedObject var obs = Observer()
    @State var txt = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass").font(.body)
                        TextField("Search For Recipies", text: $obs.query)
                    }.padding()
                    .background(Color.orange)
                    .cornerRadius(20)
                    .padding(10)
                    
                    List(obs.recipes) {i in
                        HStack {
                            AnimatedImage(url: URL(string: i.image)).resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(20, antialiased: false)
                            VStack {
                                Text(i.label).bold()
                                Text("\(i.calories) kcal")
                            }
                        }
                    }
                }.navigationBarTitle("Recipes")
                .navigationBarItems(leading: Button(action: {
                        self.size = 10
                    }, label: {
                        Image(systemName: "list.dash").resizable().frame(width: 20, height: 20)
                    }).foregroundColor(.black))
            }
            HStack {
                MenuView(size: $size)
                .cornerRadius(20)
                .padding(.leading, -size)
                .offset(x: -size)
                Spacer()
            }
        }.animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
