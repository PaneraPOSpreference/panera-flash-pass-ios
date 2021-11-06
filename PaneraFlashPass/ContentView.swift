//
//  ContentView.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    

        TabView{
            MainView()
                .tabItem{Text("Main Page")}
            accountView()
                .tabItem{Text("Welcome")}
        }
        .tabViewStyle(PageTabViewStyle())

    
    
    
}
struct accountView:View{
    var body: some View {
        VStack{
            Text("Welcome to account view")
        }
    }
}
struct MainView: View{
    var body: some View{
        VStack{
        PaneraLogo()
        Welcome(username: "Jacob")
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
}
