//
//  CategoryCell.swift
//  Landmarks
//
//  Created by 任成 on 2020/5/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct CategoryCell: View {
    var categoryName: String
    var landmarks: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach<Range<Int>, Int, CategoryItem>(0..<landmarks.count, id: \.self) { index in
                        CategoryItem(landmark: self.landmarks[index], index: index)
                    }
                }
            }
        }
        .padding([.top, .bottom], 8)
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(categoryName: landmarkData[0].category.rawValue,
                     landmarks: Array(landmarkData.prefix(4)))
        .previewLayout(.fixed(width: 800, height: 300))
    }
}

struct CategoryItem: View {
    var landmark: Landmark
    var index: Int
    var body: some View {
        NavigationLink(destination: LandmarkDetail(landmark: landmark).environmentObject(UserData())) {
            VStack(alignment: .leading) {
                landmark.image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                Text(landmark.name)
                    .foregroundColor(.primary)
            }
            .padding(.leading, index == 0 ? 15 : 0)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: landmarkData[0], index: 1)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
