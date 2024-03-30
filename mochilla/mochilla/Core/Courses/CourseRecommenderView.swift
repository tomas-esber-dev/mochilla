//
//  CourseRecommenderView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/30/24.
//

import SwiftUI

struct CourseRecommenderView: View {
    
//    @State var things : [String: DBUserCourses] = [:]
    @State var distances : [String: Double] = [:]
    
    var body: some View {
//        Text(things["53rXnyFvnhPX6S4MQAPfa7HscJ92"]?.userCourses[0].courseCode ?? "BOO")
        Text("Hey")
            .task {
                do {
//                    self.things = try await RecommendedCourses().fetchAllDocuments()
                    self.distances = RecommendedCourses().calculateDistanceFromNeighbors(userProfile:    UserProfile(userId: "MxbiBIyp1bSD8v7BDGmri1b5uvz1", ratings: [DBCourse(courseName: "ENGLISH", courseCode: "203A", rating: 3),DBCourse(courseName: "ENGLISH", courseCode: "198FS", rating: 4)]))
                } catch {
                    print("Error fetching documents: \(error)")
                }
            }
    }
}

struct CourseRecommenderView_Previews: PreviewProvider {
    static var previews: some View {
        CourseRecommenderView()
    }
}
