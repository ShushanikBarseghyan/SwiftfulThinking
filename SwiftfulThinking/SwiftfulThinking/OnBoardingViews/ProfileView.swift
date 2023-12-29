//
//  ProfileView.swift
//  SwiftfulThinking
//
//  Created by Shushan Barseghyan on 29.12.23.
//

import SwiftUI

struct ProfileView: View {
  
  @AppStorage("name") var currentUserName: String?
  @AppStorage("age") var currentUserAge: Int?
  @AppStorage("gender") var currentUserGender: String?
  @AppStorage("sighed_in") var currentUserSignedIn: Bool = false
  
  var body: some View {
    VStack(spacing: 20){
      Image(systemName: "person.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 150, height: 150)
      Text(currentUserName ?? "User Name")
      Text("\(currentUserAge ?? 0) years old")
      Text("The gender: \(currentUserGender ?? "Unknown")")
      
      Text("Sign out")
        .foregroundColor(.white)
        .font(.title)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color(.black))
        .cornerRadius(10)
        .padding()
        .onTapGesture {
          signOut()
        }
    }
    .font(.title2)
    .foregroundColor(.purple)
    .padding(40)
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 10)
  }
  
  func signOut() {
    currentUserAge = nil
    currentUserName = nil
    currentUserGender = nil
    withAnimation(.spring()) {
      currentUserSignedIn = false
    }
  }
  
}

#Preview {
  ProfileView()
}


