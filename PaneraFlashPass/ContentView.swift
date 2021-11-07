//
//  ContentView.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    @State var currentAccount = User(name: "", id: "", favs: [], history: [], boardPref: "")
    
    var body: some View {
        

        TabView{
            MainView(user: currentAccount)
                .tabItem{Text("Main Page")}
            NumberEntry()
                .tabItem{Text("NumberEntry")}
            accountManagement(ourUser: currentAccount)
                .tabItem{Text("Welcome")}

        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear(perform: postUserID)
        
    
    }
        
    func postUserID(){
        guard let url = URL(string: "https://breadpass.vercel.app/api/user") else{
            return
        }
        var request = URLRequest(url: url)
        //method,body,headers
        request.httpMethod = "POST"
        //make the request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "userId" : "HHGXWBTYFL",
            "_from": "app"
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request){
            data ,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONDecoder().decode(UserInfo.self, from: data)
                print("SUCCESS: \(String(describing: response.data.first?.id ?? "None" )) " )
                
                currentAccount.self.name = String(describing: response.data.first?.name ?? "None" )
                currentAccount.self.id = String(describing: response.data.first?.id ?? "None" )
                
            }
            catch {
                print(error)
            }
        }

        task.resume()
        
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

