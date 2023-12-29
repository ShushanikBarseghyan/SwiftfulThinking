//
//  IntroView.swift
//  SwiftfulThinking
//
//  Created by Shushan Barseghyan on 24.12.23.
//

import SwiftUI

struct IntroView: View {
  
  @AppStorage("sighed_in") var currentUserSignedIn: Bool = false
  
  var body: some View {
    ZStack{
      
      RadialGradient(gradient: Gradient(colors: [Color(.purple), Color(.blue)]),
                     center: .topLeading,
                     startRadius: 5,
                     endRadius: UIScreen.main.bounds.height)
      .ignoresSafeArea()
      
      if currentUserSignedIn {
        ProfileView()
          .transition(.asymmetric(insertion: .move(edge: .bottom),
                                  removal: .move(edge: .top)))
      } else {
        OnboardingView()
          .transition(.asymmetric(insertion: .move(edge: .top),
                                  removal: .move(edge: .bottom)))
      }
      
    }
  }
}

#Preview {
  IntroView()
}
