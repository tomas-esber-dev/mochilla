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
    @State private var selectedTab = 0
    @ObservedObject var viewModelForCourse = UserCoursesManagerModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SearchCourseView()
                .environmentObject(courseLoader)
                .environmentObject(courseStore)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search Courses")
                }
                .tag(0)
                .toolbar {
                    if selectedTab == 0 {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Search For Courses")
                                .font(.largeTitle)
                        }
                    }
                }
            ExistingCourses(viewModel: viewModelForCourse)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Rated Courses")
                }
                .tag(1)
                .toolbar {
                    if selectedTab == 1 {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Your Rated Courses")
                                .font(.largeTitle)
                        }
                    }
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
                Image(systemName: "star.fill")
                Text("Recommended")
            }
            .tag(2)
            .task {
                try? await viewModel.loadCurrentUser()
            }
            .toolbar {
                if selectedTab == 2 {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Recommendations")
                            .font(.largeTitle)
                    }
                }
            }
        }
        .navigationTitle("Mochila")
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
