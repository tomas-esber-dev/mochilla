//
//  CourseAPIClient.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

protocol CourseAPI{
    
    func fetchCourses(subject: String) async throws -> CourseSummaries
    
}

struct CoursesAPIClient: CourseAPI, APIClient {
  let session: URLSession = .shared

    func fetchCourses(subject: String) async throws -> CourseSummaries {
    let path = CoursesEndpoint.path(queryType: .subject)
    let response: CoursesResponse = try await performRequest(url: path)
        return response.ssrGetCoursesResp.courseSearchResult.subjects.subject.courseSummaries
  }
}

struct MockCoursesAPIClient: CourseAPI {
    func fetchCourses(subject: String) async throws -> CourseSummaries {
        CoursesResponse.mock().ssrGetCoursesResp.courseSearchResult.subjects.subject.courseSummaries
    }
}
