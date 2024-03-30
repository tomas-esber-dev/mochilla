//
//  SearchCourseViewModel.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

struct SearchCourseViewModel {
    static func listOfferings() -> [CourseOffering] {
        [
         CourseOffering(courseName: "Computer Science", courseCode: "COMPSCI"),
         CourseOffering(courseName: "Mathematics", courseCode: "MATH"),
         CourseOffering(courseName: "English", courseCode: "ENGLISH"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Economics", courseCode: "ECON")
        ]
    }
}

struct CourseOffering {
    var courseName : String
    var courseCode : String
}
