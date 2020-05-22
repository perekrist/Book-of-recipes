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
                        Button(action: {
                            
                        }) {
                            Text("Balanced")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 2))
                            
                        }.padding(.leading, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("High-Fiber")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 2))
                        }.padding(.horizontal, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("High-Protein")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 2))
                        }.padding(.trailing, 10)
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
