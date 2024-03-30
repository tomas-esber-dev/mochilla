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
}
