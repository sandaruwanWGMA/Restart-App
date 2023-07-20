//
//  Home.swift
//  Restart
//
//  Created by Molindu Achintha on 2023-07-20.
//

import SwiftUI

struct Home: View {
    //MARK: - PROPERTY
    @AppStorage("onboarding") var isOnBoardingViewActive = true
    
    var body: some View {
        VStack(spacing: 20){
            //MARK: - HEADER
            Spacer()
            ZStack{
                CircleGroupView(shapeColor: Color.gray, shapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
            }//: ZSTACK
            
            //MARK: - CENTER
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: - FOOTER
            Spacer()
            Button(action:{
                isOnBoardingViewActive = true
            }){
                Image(systemName: "arrow.triangle.2.circlepath.circle")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }//: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }//: VSTACK
    }
}

//MARK: - PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
