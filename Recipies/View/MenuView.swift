//
//  MenuView.swift
//  Recipies
//
//  Created by Перегудова Кристина on 20.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI

struct MenuView: View {

    @Binding var size : CGFloat
    @State var isSearch = true

    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.size =  UIScreen.main.bounds.width / 1.6
                }) {
                    Image(systemName: "xmark").resizable().frame(width: 15, height: 15).padding()
                }.background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
            }
            
            Text("In favorites: 5")
            Text("In cashe: 12")
            
            Button(action: {
                self.size =  UIScreen.main.bounds.width / 1.6
                self.isSearch = true
            }) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding()
                    Text("Search recipe")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 20)
                .background(isSearch ? Color.green : Color.gray)
                .cornerRadius(20)
            }
            
            Button(action: {
                self.size =  UIScreen.main.bounds.width / 1.6
                self.isSearch = false
            }) {
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding()
                    Text("Favourive")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 20)
                .background(isSearch ? Color.gray : Color.green)
                .cornerRadius(20)
            }
            Spacer()
        }.frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.gray)
    }
}
