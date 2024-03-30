//
//  ProfileView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    @EnvironmentObject var courseLoader: CourseLoader
    @EnvironmentObject var courseStore: CourseStore
    
    @ObservedObject var viewModelForCourse = UserCoursesManagerModel()
    
    var body: some View {
        TabView {
            SearchCourseView()
                .environmentObject(courseLoader)
                .environmentObject(courseStore)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Search Courses")
                }
            ExistingCourses(viewModel: viewModelForCourse)
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Rated Courses")
                }
            VStack {
                List {
                    if let user = viewModel.user {
                        Text("UserId: \(user.userId)")
                        
                        if let email = user.email {
                            Text("User Email: \(email)")
                        }
                    }
                }
                CourseRecommenderView(viewModelForMyCourse: viewModelForCourse)
            }
            .tabItem {
                Image(systemName: "3.square.fill")
                Text("Recommended")
            }
            .task {
                try? await viewModel.loadCurrentUser()
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(showSignInView: .constant(false))
                .environmentObject(CourseLoader(apiClient: MockCoursesAPIClient()))
                .environmentObject(CourseStore())
        }
    }
}
