//
//  UserView.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/5/21.
//

import SwiftUI
import Combine

struct UserView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PaneraText: View{
    var input: String
    var textSize: Int
    var body: some View{
        Text(input)
        .font(Font.custom("panera", size: CGFloat(textSize)))    }
          
    }
struct Welcome:View{
    var ourUser: User
    var body: some View{
        Text("Hello, \(ourUser.name)!")
            .font(Font.custom("roboto-medium", size: 25))
        Text("Please present your Panera Bread Pass to the cashier for a custom ordering experience")
            .font(Font.custom("roboto-medium", size: 20))
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding(.bottom)
            
    }
}
struct accountManagement:View{
    var ourUser: User
    var body: some View{
        VStack{
            PaneraLogo()
            Text("Name: \(ourUser.name)")
                .font(Font.custom("roboto-medium", size: 20))
                .padding(.bottom,20)
            Text("ID:  \(ourUser.id)")
                .font(Font.custom("roboto-medium", size: 20))
                .padding(.bottom,20)
            Text("Board Preference: \(ourUser.boardPref)")
                .font(Font.custom("roboto-medium", size: 20))
                .padding(.bottom,20)
        }
    }
}


struct NumberEntry: View {
    @State var currentNumber = "0"
    @State var justOrdered: String = "Menu Item"
    @State var justPriced: String = "$ --.--"
    @State var numberArray: [String] = []
    var body: some View {
        VStack{
        PaneraLogo()
        
        Text("Please Enter Your Order Number From The Screen")
                .multilineTextAlignment(.center)
                .font(Font.custom("roboto-medium", size: 20))
                .padding(.bottom,20)
        Text(justOrdered)
                .multilineTextAlignment(.center)
                .font(Font.custom("roboto-medium", size: 20))
                .foregroundColor(Color("PaneraGreen"))
        Text(justPriced)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("roboto-medium", size: 20))
                    .foregroundColor(Color("PaneraGreen"))
                    .padding(.bottom,20)
        TextField("Order Number", text: $currentNumber)
            //.border(.brown)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(Font.system(size: 60, design: .default))
            
            .onReceive(Just(currentNumber)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.currentNumber = filtered
                }
            }
            Button(action: sendOrder){
                Text("ADD ITEM")
                .multilineTextAlignment(.center)
                .font(Font.custom("roboto-medium", size: 30))
                .foregroundColor(Color("PaneraGreen"))
            }
            Button(action: sendCart){
                Text("SEND ORDER")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("roboto-medium", size: 30))
                    .foregroundColor(Color("SEND"))
                }

        }
    }
    func sendOrder(){
        guard let url = URL(string: "https://breadpass.vercel.app/api/user/orders/add") else{
            return
        }
        var request = URLRequest(url: url)
        //method,body,headers
        request.httpMethod = "POST"
        //make the request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "userId" : "HHGXWBTYFL",
            "itemId": self.currentNumber
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request){
            data ,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONDecoder().decode(orderInfo.self, from: data)
                print("SUCCESS: \(String(describing: response.data.first?.name ?? "None" )) " )
                self.justOrdered = String(describing: response.data.first?.name ?? "None" ) + " just added! "
                self.justPriced = "$ " + String(describing: response.data.first?.price ?? "None" )
                
            }
            catch {
                print(error)
            }
        }

        task.resume()
    }
    func sendCart(){
        guard let url = URL(string: "https://breadpass.vercel.app/api/user/orders/add") else{
            return
        }
        var request = URLRequest(url: url)
        //method,body,headers
        request.httpMethod = "POST"
        //make the request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "userId" : "GAKG"
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request){
            data ,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONDecoder().decode(UserInfo.self, from: data)
                print("SUCCESS: \(response) " )
                
                
            }
            catch {
                print(error)
            }
        }

        task.resume()
    }

    }



struct PaneraLogo:View{
    var body: some View{
        VStack{
        Image(systemName: "person.crop.circle")
                    .font(.system(size: 56.0))
                    .foregroundColor(Color("PaneraGreen"))
        PaneraText(input: "Panera", textSize: 40)
        PaneraText(input: "Bread Pass", textSize: 30)
                .foregroundColor(Color("PaneraGreen"))
        }
    }
}

struct QR_Block: View{
    var body: some View{
        ZStack{
        Image("userCode1")
                .resizable()
                .aspectRatio(contentMode: .fit)

        
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
