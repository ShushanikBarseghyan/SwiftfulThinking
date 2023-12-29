//
//  OnboardingView.swift
//  SwiftfulThinking
//
//  Created by Shushan Barseghyan on 24.12.23.
//

import SwiftUI

struct OnboardingView: View {
  
  @State private var onboardingState: Int = 0
  @State private var name: String = ""
  @State private var age: Double = 21
  @State private var gender: String = ""
  @State private var alertTitle: String = ""
  @State private var showAlert: Bool = false
  
  
  let transition: AnyTransition = .asymmetric(
    insertion: .move(edge: .trailing),
    removal: .move(edge: .leading))
  
  @AppStorage("name") var currentUserName: String?
  @AppStorage("age") var currentUserAge: Int?
  @AppStorage("gender") var currentUserGender: String?
  @AppStorage("sighed_in") var currentUserSignedIn: Bool = false
  
  //Onboarding States
  /*
   0 - Welcome Scree
   1 - Add name
   2 - Add age
   3 - Add gender
   */
  
  var body: some View {
    ZStack {
      
      ZStack {
        switch onboardingState {
        case 0:
          welcomeSection
            .transition(transition)
        case 1:
          addNameSection
            .transition(transition)
        case 2:
          addAgeSection
            .transition(transition)
        case 3:
          addGenderSection
            .transition(transition)
        default:
          RoundedRectangle(cornerRadius: 25.0) .foregroundColor(.green)
        }
      }
      
      VStack{
        Spacer()
        
        Button(action: {
          
        }, label: {
          bottomButtom
        })
        .padding()
      }
    }
    .alert(isPresented: $showAlert, content: {
      return Alert(title: Text(alertTitle))
    })
  }
  
  
}

#Preview {
  OnboardingView()
    .background(Color.purple)
}


//MARK: Components
extension OnboardingView {
  private var bottomButtom: some View {
    Text(onboardingState == 0 ? "Sign Up" : onboardingState == 3 ? "Finish" : "Next")
      .font(.title2)
      .foregroundColor(.purple)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .cornerRadius(10)
      .onTapGesture {
        handleNextButtonPress()
      }
  }
  
  private var welcomeSection: some View {
    VStack{
      Spacer()
      Image(systemName: "heart.text.square.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .foregroundColor(.white)
      Text("Find your match")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.white)
        .overlay(
          Capsule(style: .continuous)
            .frame(height: 3)
            .offset(y:5),
          alignment: .bottom
        )
        .foregroundColor(.white)
      Text("This is an online dating app the real purpose of which is showing some swiftUI skills")
        .fontWeight(.medium)
        .foregroundColor(.white)
        .padding(.vertical)
      Spacer()
      Spacer()
    }
    .multilineTextAlignment(.center)
    .padding()
  }
  
  private var addNameSection: some View {
    VStack{
      Spacer()
      Text("What's your name?")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.white)
      TextField("Type your name here",
                text: $name)
      .font(.headline)
      .frame(height: 55)
      .padding(.horizontal)
      .background(Color.white)
      .cornerRadius(10)
      Spacer()
      Spacer()
    }
    .padding()
  }
  
  private var addAgeSection: some View {
    VStack{
      Spacer()
      Text("What's your age?")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.white)
      Slider(value: $age,
             in: 18...100,
             step: 1)
      .accentColor(.white)
      Text( String(format: "%.0f", age))
        .font(.title)
        .fontWeight(.semibold)
        .foregroundColor(.white)
      Spacer()
      Spacer()
    }
    .padding()
  }
  
  private var addGenderSection: some View {
    VStack{
      Spacer()
      Text("What's your gender?")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.white)
      Text(gender.count > 1 ? "Selected gender: \(gender)" : "Select your gender")
        .font(.headline)
        .foregroundColor(.purple)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(5)
      Picker(selection: $gender,
             label:
              Text("Your gender"),
             content: {
        Text("Male").tag("Male")
        Text("Female").tag("Female")
        Text("Non-Binary").tag("Non-Binary")
      })
      .pickerStyle(MenuPickerStyle())
      .font(.headline)
      .accentColor(.purple)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .cornerRadius(5)
      Spacer()
      Spacer()
    }
    .padding()
  }
}

//MARK: Functions
extension OnboardingView {
  func handleNextButtonPress() {
    switch onboardingState {
    case 1:
      guard name.count >= 3 else {
        showAlert(title: "The name must be at leat 3 characters long")
        return
      }
    case 3:
      guard gender.count > 1 else {
        showAlert(title: "Please select a gender")
        return
      }
    default:
      break
    }
    
    if onboardingState == 3 {
      signIn()
    } else {
      withAnimation(.spring){
        onboardingState += 1
      }
    }
  }
  
  func signIn() {
    currentUserName = name
    currentUserAge = Int(age)
    currentUserGender = gender
    withAnimation(.spring()) {
      currentUserSignedIn = true
    }
  }
  
  func showAlert(title: String) {
    alertTitle = title
    showAlert.toggle()
  }
}

