//
//  ContentView.swift
//  Restart
//
//  Created by Molindu Achintha on 2023-07-20.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive = true
    var body: some View {
        ZStack{
            if isOnBoardingViewActive{
                OnBoarding()
            }
            else{
                Home()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
