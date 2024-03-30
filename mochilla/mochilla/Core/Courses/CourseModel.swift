//
//  CourseModel.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

struct Course: Identifiable {
    var id: UUID = UUID()
    var subject: String
    var catalogNumber: String
    var effectiveDate: String
    var rating: Int
}

extension Course {
    static let previewData: [Course] = []
}

