//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 任成 on 2020/5/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            Toggle(isOn: $userData.showFavorite) {
                Text("只显示收藏")
            }
            ForEach(userData.landmarks) { landmark in
                if !self.userData.showFavorite || landmark.isFavorite {
                    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
        }
        .navigationBarTitle(Text("世界地图"))
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            NavigationLink(destination: AnimationDetail()) {
                Image(systemName: "stopwatch")
            }
        }))
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList().environmentObject(UserData())
//        ForEach(["iPhone 11", "iPhone 8"], id: \.self) { deviceName in
//            LandmarkList().environmentObject(UserData())
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
    }
}
