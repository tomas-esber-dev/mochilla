//
//  ExistingCourses.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import SwiftUI

struct ExistingCourses: View {
    
    @ObservedObject var viewModel = UserCoursesManagerModel()

    var body: some View {
        VStack {
            List(viewModel.userCourses) { userCourse in
                ForEach(userCourse.userCourses, id: \.self) { course in
                    VStack(alignment: .leading) {
                        Text(course.courseName)
                        Text(course.courseCode)
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

struct ExistingCourses_Previews: PreviewProvider {
    static var previews: some View {
        ExistingCourses()
    }
}
