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
    
    @State private var view = 0
    @State private var size = UIScreen.main.bounds.width / 1.6
    @State var isOpen = false
    
    @ObservedObject private var recipeViewModel = Observer()
    
    @State private var show = false
    @State private var id = 0
    
    
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                self.size = 10
                                self.isOpen.toggle()
                            }, label: {
                                Image(systemName: "list.dash").resizable().frame(width: 20, height: 20)
                            }).foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                        }
                        
                        Text("Recipes")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        
                    }.padding(.top, 10)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass").font(.body)
                        TextField("Search For Recipies", text: $recipeViewModel.query)
                            .font(.body)
                        
                        if recipeViewModel.query != "" {
                            Button(action: {
                                self.recipeViewModel.query = ""
                            }) {
                                Image(systemName: "clear.fill")
                                    .font(.body)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(10)
                    
                    HStack {
                        DietButton(type: "balanced", recipeViewModel: self.recipeViewModel)
                        Spacer()
                        DietButton(type: "high-fiber", recipeViewModel: self.recipeViewModel)
                        Spacer()
                        DietButton(type: "high-protein", recipeViewModel: self.recipeViewModel)
                        
                    }.padding(.bottom, 20)
                }
                .padding(.top, 25)
                .padding(.horizontal, 10)
                .background(Color.purple)
                .clipShape(Rounded2())
                .edgesIgnoringSafeArea(.top)
                
                List(recipeViewModel.recipes) { i in
                    HStack {
                        AnimatedImage(url: URL(string: i.image)).resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            Text(i.label).bold()
                            Text("\(i.calories) kcal")
                                .foregroundColor(.gray)
                        }
                    }.onTapGesture {
                        self.show.toggle()
                        self.id = i.id
                    }.sheet(isPresented: self.$show) {
                        RecipeView(obs: self.recipeViewModel, index: self.$id)
                    }.padding(.vertical)
                }
            }
            .offset(x: isOpen ? 300 : 0)
            
            if isOpen {
                Rectangle()
                    .edgesIgnoringSafeArea(.vertical)
                    .opacity(0.6)
                    .onTapGesture {
                        self.isOpen.toggle()
                }
                
                HStack {
                    List {
                        Text("Search")
                        Text("Favourite")
                    }
                    .frame(width: 300)
                    .padding(.top, 44)
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                
            }
            
        }
        .animation(.easeOut)
    }
}

struct DietButton: View {
    @State var type: String
    @ObservedObject var recipeViewModel: Observer
    
    var body: some View {
        Button(action: {
            if self.recipeViewModel.diet != self.type {
                self.recipeViewModel.diet = self.type
            } else {
                self.recipeViewModel.diet = ""
            }
        }) {
            Text(type)
                .foregroundColor(self.recipeViewModel.diet == type ? .purple : .white)
                .padding(6)
                .background(RoundedRectangle(cornerRadius: 30).stroke(self.recipeViewModel.diet == type ? Color.purple : Color.white, lineWidth: 2).background(self.recipeViewModel.diet == type ? Color.white : Color.purple))
        }.padding(.horizontal, 10)
    }
}
