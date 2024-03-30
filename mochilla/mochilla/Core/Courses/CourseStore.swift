//
//  CourseStore.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

class CourseStore: ObservableObject {
    @Published var courses: [Course] = Course.previewData
    
    func populateCourseStore(apiCourses: CourseSummaries) {
        apiCourses.courseSummary.forEach { course in
            let courseModel = Course(subject: course.subject, catalogNumber: course.catalogNbr, effectiveDate: course.effdt, rating: 1)
            courses.append(courseModel)
        }
    }
}
