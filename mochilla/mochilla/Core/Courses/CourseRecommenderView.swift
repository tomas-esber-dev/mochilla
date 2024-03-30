//
//  CourseRecommenderView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/30/24.
//

import SwiftUI

@MainActor
final class CourseRecommenderViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct CourseRecommenderView: View {
    
//    @State var things : [String: DBUserCourses] = [:]
    @State var distances : [UserProfile: Double] = [:]
    @State var items : [DBCourse] = []
    @StateObject private var viewModel = CourseRecommenderViewModel()
    
    var body: some View {
//        Text(things["53rXnyFvnhPX6S4MQAPfa7HscJ92"]?.userCourses[0].courseCode ?? "BOO")
        Text("Hey")
            .task {
                do {
//                    self.things = try await RecommendedCourses().fetchAllDocuments()
                    self.distances = await RecommendedCourses().calculateDistanceFromNeighbors(userId: String(viewModel.user?.userId ?? "53rXnyFvnhPX6S4MQAPfa7HscJ92")).value
                } catch {
                    print("Error fetching documents: \(error)")
                }
            }
            .task {
                self.items = RecommendedCourses().fetchCourses(userProfile: UserProfile(userId: "MxbiBIyp1bSD8v7BDGmri1b5uvz1", ratings: [DBCourse(courseName: "COMPSCI", courseCode: "20", rating: 5),DBCourse(courseName: "COMPSCI", courseCode: "89S", rating: 4)]), userList: self.distances, distanceThreshhold: 1.0)
            }
    }
}

struct CourseRecommenderView_Previews: PreviewProvider {
    static var previews: some View {
        CourseRecommenderView()
    }
}
