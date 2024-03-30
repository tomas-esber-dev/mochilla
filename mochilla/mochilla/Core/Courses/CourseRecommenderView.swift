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
    @StateObject private var viewModel = CourseRecommenderViewModel()
    @StateObject var courseViewModel = CourseRecommenderModel()
    
//    @ObservedObject var viewModelForMyCourse = UserCoursesManagerModel()
    @ObservedObject var viewModelForMyCourse : UserCoursesManagerModel

    
    let auth = try? AuthenticationManager.shared.getAuthenticatedUser().uid
    
    var body: some View {
        VStack {
//            Text("hey")
//            //            ForEach(courseViewModel.items, id: \.self) { course in
//            //                VStack(alignment: .leading) {
//            //                    Text(course.courseName)
//            //                    Text(course.courseCode)
//            //                }
//            //            }
//                .task {
//                    do {
//                        viewModelForMyCourse.fetchData(forUserID: auth ?? "ah, trouble getting user here")
//                    } catch {
//                        print("Error fetching courses for user: \(error)")
//                    }
//                }
//            Text("Length is \(courseViewModel.items.count)")
            List(courseViewModel.items, id: \.self) { course in
                VStack(alignment: .leading) {
                    Text(course.courseName)
                        .font(.headline)
                    Text(course.courseCode)
                        .font(.subheadline)
                }
            }
            .task {
                do {
                    try await courseViewModel.calculateDistances(userId: auth ?? "trouble getting user", userCourses: viewModelForMyCourse.userCourses)
                } catch {
                    print("Error fetching documents: \(error)")
                }
                courseViewModel.fetchCourses(userId: auth ?? "some more trouble here", userCourses: viewModelForMyCourse.userCourses, distanceThreshold: 1.0)
            }
        }
    }
}
    
struct CourseRecommenderView_Previews: PreviewProvider {
    static var previews: some View {
        CourseRecommenderView(viewModelForMyCourse: UserCoursesManagerModel())
    }
}
    
    //            .onAppear {
    //                courseViewModel.fetchCourses(userId: String(viewModel.user?.userId ?? "53rXnyFvnhPX6S4MQAPfa7HscJ92"), distanceThreshold: 1.0)
    //                self.items = RecommendedCourses().fetchCourses(userId: String(viewModel.user?.userId ?? "53rXnyFvnhPX6S4MQAPfa7HscJ92"), userList: self.distances, distanceThreshhold: 1.0)
    //            }
    //        Text(things["53rXnyFvnhPX6S4MQAPfa7HscJ92"]?.userCourses[0].courseCode ?? "BOO")
    //        Text("Hey")
    //            .task {
    //                do {
    ////                    self.things = try await RecommendedCourses().fetchAllDocuments()
    //                    self.distances = await RecommendedCourses().calculateDistanceFromNeighbors(userId: String(viewModel.user?.userId ?? "53rXnyFvnhPX6S4MQAPfa7HscJ92")).value
    //                } catch {
    //                    print("Error fetching documents: \(error)")
    //                }
    //            }
    //            .task {
    //                self.items = RecommendedCourses().fetchCourses(userProfile: UserProfile(userId: "MxbiBIyp1bSD8v7BDGmri1b5uvz1", ratings: [DBCourse(courseName: "COMPSCI", courseCode: "20", rating: 5),DBCourse(courseName: "COMPSCI", courseCode: "89S", rating: 4)]), userList: self.distances, distanceThreshhold: 1.0)
    //            }
