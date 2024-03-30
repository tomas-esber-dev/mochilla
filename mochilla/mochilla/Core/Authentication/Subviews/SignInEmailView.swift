//
//  SignInEmailView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Image("Mochila1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
//            Spacer()
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                // this is one button, but we can split this into two buttons (e.g., sign up, sign in)
                Task {
                    // try to sign up the user
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                    
                    // if that fails, then sign them in
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInEmailView(showSignInView: .constant(false))
    }
}
