//
//  RootView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @EnvironmentObject var courseLoader: CourseLoader
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    ProfileView(showSignInView: $showSignInView)
                        .environmentObject(courseLoader)
                }
            }
        }
        .onAppear {
            // get an existing authenticated user
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(CourseLoader(apiClient: MockCoursesAPIClient()))
    }
}
