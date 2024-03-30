//
//  CourseRecommenderViewModel.swift
//  mochilla
//
//  Created by Tomas Esber on 3/30/24.
//

import Foundation

class CourseRecommenderModel: ObservableObject {
    @Published var distances: [UserProfile: Double] = [:]
    @Published var items: [DBCourse] = []
    
    func calculateDistances(userId: String, userCourses: [DBUserCourses]) async throws {
        print("in course recommender model, going to call calculate distance")
        self.distances = await RecommendedCourses().calculateDistanceFromNeighbors(userId: userId, userCourses: userCourses).value
    }
    
    func fetchCourses(userId: String, userCourses: [DBUserCourses], distanceThreshold: Double) {
        do {
            self.items = RecommendedCourses().fetchCourses(userId: userId, myUserCourses: userCourses, userList: self.distances, distanceThreshhold: distanceThreshold)
        } catch {
            print("Error fetching courses: \(error)")
        }
    }
}
