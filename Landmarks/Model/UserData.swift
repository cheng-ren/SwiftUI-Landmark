//
//  UserData.swift
//  Landmarks
//
//  Created by 任成 on 2020/5/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var showFavorite = false
    @Published var landmarks = landmarkData
}
