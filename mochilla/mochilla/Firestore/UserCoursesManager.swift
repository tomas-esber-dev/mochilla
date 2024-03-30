//
//  UserCoursesManager.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUserCourses: Codable, Identifiable {
    @DocumentID var id: String?
    var userCourses: [DBCourse]
}

struct DBCourse: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var courseName: String
    var courseCode: String
    var rating: Int
}

class UserCoursesManagerModel: ObservableObject {
    @Published var userCourses: [DBUserCourses] = []
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("userCourses").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            if let documents = snapshot?.documents {
                self.userCourses = documents.compactMap { document in
                    do {
                        let userCourses = try document.data(as: DBUserCourses.self)
                        print(userCourses)
                        return userCourses
                    } catch {
                        print("Error decoding user courses: \(error)")
                        return nil
                    }
                }
            }
        }
    }
    
    func addCourse(course: DBCourse, toUserWithID userID: String) {
        // Create a reference to the user's document in the "userCourses" collection
        let userDocRef = db.collection("userCourses").document(userID)
        
        // Update the document with the new course added to the array
        userDocRef.getDocument { document, error in
            if let error = error {
                print("Error getting document: \(error)")
                return
            }
            
            if let document = document, document.exists {
                do {
                    // Decode the existing userCourses array from Firestore
                    var userCourses = try document.data(as: DBUserCourses.self)
                    
                    // Append the new course to the userCourses array
                    userCourses.userCourses.append(course)
                    
                    // Encode the updated userCourses array and update the Firestore document
                    try userDocRef.setData(from: userCourses)
                } catch {
                    print("Error decoding or updating document: \(error)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
