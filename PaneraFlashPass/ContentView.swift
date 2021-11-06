//
//  ContentView.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
        let currentAccount = User(name: "John", id: 12345, favs: [], history: [], boardPref: "Dark")
        TabView{
            MainView(user: currentAccount)
                .tabItem{Text("Main Page")}
            accountManagement(ourUser: currentAccount)
                .tabItem{Text("Welcome")}
        }
        .tabViewStyle(PageTabViewStyle())

    
    
    }
    }   


struct MainView: View{
    var user: User
    var body: some View{
        VStack{
        PaneraLogo()
        Welcome(ourUser: user)
        QR_Block()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
        
    }
}

