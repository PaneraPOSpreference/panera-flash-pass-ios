//
//  ContentView.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
    VStack{
    PaneraLogo()
        
    Welcome(username: "Jacob Woods")
    Spacer()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
        
    }
}
}
