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
    @State private var imageOffSet: CGSize = CGSize(width: 0, height: 0)
    @State private var arrowOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    @State private var textOpacity = 1.0
    
    let hapicFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20){
                // MARK: - HEADER
                Spacer()
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
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
                        .offset(x:imageOffSet.width * -1)
                        .blur(radius: abs(imageOffSet.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffSet.width)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 2), value: isAnimating)
                        .offset(x: imageOffSet.width, y: 0)
                        .rotationEffect(.degrees(imageOffSet.width / 20))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(gesture.translation.width) <= UIScreen.main.bounds.width - 130{
                                        hapicFeedback.notificationOccurred(.success)
                                        imageOffSet = gesture.translation
                                        textTitle = "Give."
                                        withAnimation(.linear(duration: 0.25)){
                                            arrowOpacity = 0
                                        }
                                    }
                                })
                                .onEnded({_ in
                                    imageOffSet = CGSize(width: 0, height: 0)
                                    withAnimation(.linear(duration: 0.2)){
                                        hapicFeedback.notificationOccurred(.warning)
                                        arrowOpacity = 1
                                        textTitle = "Share."
                                    }
                                    
                                })
                            
                        )//: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                        
                }//: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .light))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(arrowOpacity)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    ,alignment: .bottom
                )
                
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
                                    withAnimation(Animation.easeIn(duration: 0.4)){
                                        if buttonOffSet > buttonWidth / 2{
                                            buttonOffSet = buttonWidth - 80
                                            capsuleWidth = buttonOffSet + 80
                                            isOnBordingActive = false
                                            playSound(sound: "chimeup", type: "mp3")
                                        }else{
                                            buttonOffSet = 0
                                            capsuleWidth = 80
                                        }
                                    }
                                })//: ONENDED
                            
                        )//: GESTURE
                        
                        Spacer()
                    }//: HSTACK
                    
                }//: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(.vertical, 10)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
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
