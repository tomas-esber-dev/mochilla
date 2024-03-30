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
         CourseOffering(courseName: "African & African Amer Studies", courseCode: "AAAS"),
         CourseOffering(courseName: "Arabic", courseCode: "ARABIC"),
         CourseOffering(courseName: "Biochemistry", courseCode: "BIOCHEM"),
         CourseOffering(courseName: "Biomedical Engineering", courseCode: "BME"),
         CourseOffering(courseName: "Chemistry", courseCode: "CHEM"),
         CourseOffering(courseName: "Classical Studies", courseCode: "CLST"),
         CourseOffering(courseName: "Computer Science", courseCode: "COMPSCI"),
         CourseOffering(courseName: "Dance", courseCode: "DANCE"),
         CourseOffering(courseName: "Decision Sciences Program", courseCode: "DECSCI"),
         CourseOffering(courseName: "Economics", courseCode: "ECON"),
         CourseOffering(courseName: "Electrical & Computer Egr", courseCode: "ECE"),
         CourseOffering(courseName: "English", courseCode: "ENGLISH"),
         CourseOffering(courseName: "Financial Technology", courseCode: "FINTECH"),
         CourseOffering(courseName: "French", courseCode: "FRENCH"),
         CourseOffering(courseName: "Mathematics", courseCode: "MATH"),
         CourseOffering(courseName: "Neuroscience", courseCode: "NEUROSCI"),
         CourseOffering(courseName: "Physics", courseCode: "PHYSICS")
        ]
    }
}

struct CourseOffering {
    var courseName : String
    var courseCode : String
}
