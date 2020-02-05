//
//  ContentView.swift
//  Moonshot
//
//  Created by Dmitry Reshetnik on 05.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
////            Image("Example")
////                .resizable()
////                .aspectRatio(contentMode: .fill)
////                .frame(width: 300, height: 300)
////               .clipped()
//            GeometryReader { geo in
//                Image("Example")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geo.size.width)
//            }
//
//            ScrollView(.vertical) {
//                VStack(spacing: 10) {
//                    ForEach(0..<100) {
//                        CustomText("Item \($0)")
//                            .font(.title)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detailed \(row)")) {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}
