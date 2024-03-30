//
//  AuthenticationView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Text("Mochila")
                .font(.custom("Comic Sans MS", size: 80)) // Custom font and size
                .fontWeight(.bold) // Bold weight
                .foregroundColor(.blue) // Text color
                .multilineTextAlignment(.center) // Center alignment
                .padding(.top, 50) // Add padding to the top
            Spacer()
            Text("Get curated recommendations for your Duke classes")
                .font(.system(size: 24, weight: .light, design: .default))
                .italic()
                .foregroundColor(.black) // Set text color
                .multilineTextAlignment(.center) // Center align the text
                .padding(.horizontal, 20) // Add horizontal padding
                .padding(.vertical, 10) // Add vertical padding
            Spacer()
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            Button(action: {
                // Action for signing in with Google
            }) {
                HStack {
                    Image("google3") // Google logo image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                    Text("Sign In With Google")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.white) // Customize color
                .cornerRadius(10)
                .overlay(
                        RoundedRectangle(cornerRadius: 10) // Add border
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
                    
        }
        .padding()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
