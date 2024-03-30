//
//  NeighborsModel.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfile {
    var userId: String
    var ratings: [DBCourse]
}

class RecommendedCourses {
    
    var recommendedCourses: [DBCourse] = []
    private var db = Firestore.firestore()
    
    // for user0, returns: [user1: 0.75, user2: 0.56, ... , user9: 0.72]
    func calculateDistanceFromNeighbors(userProfile: UserProfile) -> [String: Double] {
        Task {
            do {
                var user_distances : [String: Double] = [:]
                let userToCourses = try await fetchAllDocuments()
//                print(userToCourses)
                for user_id in userToCourses.keys {
//                    print("User id is \(user_id)")
                    if user_id == userProfile.userId {
                        continue
                    }
                    var top_calculation = 0.000001
                    var my_ratings_calculation = 0.000001
                    var their_ratings_calculation = 0.000001
                    if let userCourses = userToCourses[user_id] {
                        for i in 0..<userCourses.userCourses.count {
                            let course = userCourses.userCourses[i]
//                            print("Course id is \(course.courseCode)")
                            for my_course in userProfile.ratings {
                                let my_str = my_course.courseName.trimmingCharacters(in: .whitespacesAndNewlines) + my_course.courseCode.trimmingCharacters(in: .whitespacesAndNewlines)
                                let other_str = course.courseName.trimmingCharacters(in: .whitespacesAndNewlines) + course.courseCode.trimmingCharacters(in: .whitespacesAndNewlines)
                                if my_str == other_str {
//                                    print("Overlapping Course is \(my_str)")
                                    top_calculation += Double(course.rating * my_course.rating)
                                    my_ratings_calculation += Double(my_course.rating * my_course.rating)
                                    their_ratings_calculation += Double(course.rating * course.rating)
                                }
                            }
                        }
                    }
                    my_ratings_calculation = sqrt(my_ratings_calculation)
                    their_ratings_calculation = sqrt(their_ratings_calculation)
                    let distance = 1 - (top_calculation / (my_ratings_calculation * their_ratings_calculation))
//                    print("Distance is \(distance)")
                    user_distances[user_id] = distance
                }
                // Use fetched data here
//                print(userToCourses)
                return user_distances
            } catch {
                print("Error fetching documents: \(error)")
                return ["":0.0]
            }
        }
        return ["":0.0]
    }
    
    // returns: [Course(ENG101), Course(CS308), Course(MATH230)]
    func fetchCourses(userList: [UserProfile]) -> [DBCourse] {
        return []
    }
    
    // returns: top rated courses of the previous courses [Course(ENG101), Course(MATH230)]
    func calculateSmoothedRatings(userList: [UserProfile], courseNames: [DBCourse]) -> [DBCourse] {
        return []
    }
    
    // database operations
    
    func fetchAllDocuments() async throws -> [String: DBUserCourses] {
        let collectionRef = db.collection("userCourses")
        
        // Fetch documents asynchronously
        let querySnapshot = try await collectionRef.getDocuments()
        
        // Process fetched documents
        let documents = querySnapshot.documents
        guard !documents.isEmpty else {
            return [:] // Return empty dictionary if no documents found
        }
        
        var userToCourses = [String: DBUserCourses]()
        for document in documents {
            let documentID = document.documentID
            do {
                let userCourses = try document.data(as: DBUserCourses.self)
                userToCourses[documentID] = userCourses
            } catch {
                throw error // Propagate decoding error
            }
        }
        
        return userToCourses
    }

//    func fetchAllDocuments() -> [String : DBUserCourses] {
//        let collectionRef = db.collection("userCourses")
//        var userToCourses = [String : DBUserCourses]()
//        collectionRef.getDocuments { (querySnapshot, error) in
//            do {
//                if let error = error {
//                    throw error // Throw the error if it exists
//                }
//
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents found")
//                    return
//                }
//
//                for document in documents {
//                    let documentID = document.documentID
//                    let userCourses = try document.data(as: DBUserCourses.self)
//                    print(userCourses)
//                    userToCourses[documentID] = userCourses
//                }
//            } catch {
//                print("Error getting documents: \(error)")
//            }
//        }
//        print(userToCourses)
//        return userToCourses
//    }
}
