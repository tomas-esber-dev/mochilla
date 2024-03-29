//
//  CourseLoader.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

class CourseLoader: ObservableObject {
  let apiClient: CourseAPI

  @Published private(set) var state: LoadingState = .idle

  enum LoadingState {
    case idle
    case loading
    case success(data: CourseSummaries)
    case failed(error: Error)
  }

  init(apiClient: CourseAPI) {
    self.apiClient = apiClient
  }

  @MainActor
  func loadCourseData(subject: String) async {
    self.state = .loading
    do {
        let courses = try await apiClient.fetchCourses(subject: subject)
      self.state = .success(data: courses)
    } catch {
      self.state = .failed(error: error)
    }
  }
}

