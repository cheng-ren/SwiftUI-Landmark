//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by 任成 on 2020/5/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var userData : UserData
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    var landmark: Landmark
    
    
    @State var show = false
//    @State var viewState = CGSize.zero
//    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(coordinate: landmark.locationCoordinate)
            
                VStack {
                    CircleImage(image: landmark.image)
    //                                .offset(y: -100)
                                    .padding(.top, -120)
                    HStack {
                        HStack {
                            Text(landmark.name)
                                .font(.title)
                            Button(action: {
                                self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
                            }) {
                                if self.userData.landmarks[self.landmarkIndex].isFavorite {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                } else {
                                    Image(systemName: "star")
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                        Spacer()
                        Text("PlaceholderPlaceholderPl")
                            .frame(height: 30)
                    }
                    HStack(alignment: .top) {
                        Text(landmark.park)
                            .font(.subheadline)
                        Spacer()
                        Text(landmark.state)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .background(BlurView(style: .systemThinMaterial))
//                .frame(height: 200)
                .offset(y: screen.height)
                .offset(y: bottomState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
                .gesture(DragGesture().onChanged({ value in
                    self.bottomState = value.translation
                    if self.showFull {
                        self.bottomState.height += -300
                    }
                    if self.bottomState.height < -300 {
                        self.bottomState.height = -300
                    }
                }).onEnded({ (value) in
                    if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                        self.bottomState.height = -300
                        self.showFull = true
                    } else {
                        self.bottomState = .zero
                        self.showFull = false
                    }
                }))
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarTitle(Text(landmark.name))
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarkData[0]).environmentObject(UserData())
//        ForEach(["iPhone 11", "iPhone 8"], id: \.self) { deviceName in
//            LandmarkDetail(landmark: landmarkData[0]).environmentObject(UserData())
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
    }
}

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
    }
}

let screen = UIScreen.main.bounds
