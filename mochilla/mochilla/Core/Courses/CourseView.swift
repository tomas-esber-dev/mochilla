//
//  CourseView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import SwiftUI

struct CourseView: View {
    
    @EnvironmentObject var courseLoader: CourseLoader
    
    var body: some View {
        ScrollView {
            switch courseLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): Text("Error \(error.localizedDescription)")
            case .success(let courses):
                Text(courses.courseSummary.description)
            }
        }
        .task { await courseLoader.loadCourseData(subject: "AAAS")}
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
            .environmentObject(CourseLoader(apiClient: MockCoursesAPIClient()))
    }
}
