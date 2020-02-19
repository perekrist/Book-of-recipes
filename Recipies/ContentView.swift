//
//  ContentView.swift
//  Recipies
//
//  Created by Перегудова Кристина on 20.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var size = UIScreen.main.bounds.width / 1.6
    
    var body: some View {
        ZStack {
            Color.orange
            NavigationView {
                List(0 ..< 20) {i in
                    Text("Recipe \(i)")
                }.navigationBarTitle("Recipes")
                .navigationBarItems(leading: Button(action: {
                        self.size = 10
                    }, label: {
                        Image(systemName: "list.dash").resizable().frame(width: 20, height: 20)
                    }).foregroundColor(.black))
            }
            HStack {
                Menu(size: $size)
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

struct Menu : View {

    @Binding var size : CGFloat

    var body : some View{
        
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
            
            HStack {
                Image(systemName: "magnifyingglass").resizable().frame(width: 25, height: 25).padding()
                Text("Search recipe").fontWeight(.heavy)
                Spacer()
            }.padding(.leading, 20)
            
            HStack {
                Image(systemName: "star.fill").resizable().frame(width: 25, height: 25).padding()
                Text("Favourive").fontWeight(.heavy)
                Spacer()
            }.padding(.leading, 20)
            
            Spacer()
        }.frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white)
    }
}
