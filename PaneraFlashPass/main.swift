//
//  getAttributes.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/6/21.
//
import SwiftUI


func postUserID(from userId: String, completion: @escaping (String, String)->()){
    guard let url = URL(string: "https://breadpass.vercel.app/api/user") else{
        return
    }
    var request = URLRequest(url: url)
    //method,body,headers
    request.httpMethod = "POST"
    //make the request
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: AnyHashable] = [
        "userId" : userId
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
            completion(String(describing: response.data.first?.id ?? "None" ),String(describing: response.data.first?.name ?? "None" ) )
            
        }
        catch {
            print(error)
        }
    }

    task.resume()
    
}

postUserID(from: "GAKG")
{
id, name
in
print(id,name)
}
