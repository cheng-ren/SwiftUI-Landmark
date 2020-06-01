//
//  Home.swift
//  Landmarks
//
//  Created by 任成 on 2020/5/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var isPresented = false
    
    var category: [String: [Landmark]] {
        Dictionary(grouping: landmarkData) { landmark in
            landmark.category.rawValue
        }
    }
    
    var body: some View {
        
        NavigationView {
            List {
                landmarkData[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(category.keys.sorted(), id: \.self) { categoryName in
                    CategoryCell(categoryName:categoryName, landmarks:self.category[categoryName]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: LandmarkList().environmentObject(UserData())) {
                    Text("查看所有地标")
                }
            }
            .navigationBarTitle("精选")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                }).sheet(isPresented: self.$isPresented) {
                        AnimationDetail()
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
