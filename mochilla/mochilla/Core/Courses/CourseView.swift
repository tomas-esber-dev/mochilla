//
//  CourseView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import SwiftUI

struct CourseView: View {
    
    @EnvironmentObject var courseLoader: CourseLoader
    
    var courseName : String
    
    var body: some View {
        ScrollView {
            switch courseLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): Text("Error \(error.localizedDescription)")
            case .success(let courses):
                CourseListView(courses: courses)
            }
        }
        .task { await courseLoader.loadCourseData(subject: courseName)}
    }
}

struct CourseListView: View {

    var courses: CourseSummaries
    
    var body: some View {
        ForEach(courses.courseSummary, id: \.self) { course in
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(course.subject)
                        .font(.headline)
                    Text("Catalog Number: \(course.catalogNbr)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Effective Date: \(course.effdt)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
        }
    }
}

//struct CourseRowView: View {
//
//    var body: some View {
//
//    }
//}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView(courseName: "AAAS")
            .environmentObject(CourseLoader(apiClient: MockCoursesAPIClient()))
    }
}
