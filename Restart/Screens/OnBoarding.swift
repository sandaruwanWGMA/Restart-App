//
//  OnBoarding.swift
//  Restart
//
//  Created by Molindu Achintha on 2023-07-20.
//

import SwiftUI

struct OnBoarding: View {
    //MARK: - PROPERTY
    @AppStorage("onboarding") var isOnBordingActive: Bool = true
    
    @State private var buttonOffSet: CGFloat = 0
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var capsuleWidth: CGFloat = 80
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20){
                // MARK: - HEADER
                Spacer()
                VStack(spacing: 0){
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("""
                        It's not how much we give but
                        how much love we put into giving
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                }//: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0: -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - CENTER
                ZStack{
                    CircleGroupView(shapeColor: Color(.white), shapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 2), value: isAnimating)
                }//: CENTER
                Spacer()
                
                // MARK: - FOOTER
                ZStack{
                    // PARTS OF CUSTOM BUTTON
                    
                    // 1. BACKGROUND (STATIC)
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                        .frame(width: capsuleWidth)
                        
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffSet)
                        
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffSet <= buttonWidth - 80{
                                        buttonOffSet = gesture.location.x
                                        capsuleWidth = buttonOffSet + 80
                                    }
                                })//: ONCHANGED
                                .onEnded({ _ in
                                    if buttonOffSet > buttonWidth / 2{
                                        buttonOffSet = buttonWidth - 80
                                        capsuleWidth = buttonOffSet + 80
                                        isOnBordingActive = false
                                    }else{
                                        buttonOffSet = 0
                                        capsuleWidth = 80
                                    }
                                })//: ONENDED
                            
                        )//: GESTURE
                        
                        Spacer()
                    }//: HSTACK
                    
                }//: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(.vertical, 10)
                
            } //: VSTACK
            
        }//: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
