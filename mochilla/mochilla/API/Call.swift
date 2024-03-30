//
//  Call.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

struct CoursesResponse: Codable {
    let ssrGetCoursesResp: SSRGetCoursesResp
    
    enum CodingKeys: String, CodingKey {
        case ssrGetCoursesResp = "ssr_get_courses_resp"
    }
    
    static func mock() -> CoursesResponse {
        CoursesResponse(ssrGetCoursesResp:
                            SSRGetCoursesResp(courseSearchResult:
                                                CourseSearchResult(subjects:
                                                                    Subjects(subject:
                                                                                Subject(courseSummaries: CourseSummaries(courseSummary: [CourseSummary(subject: "ENG", subjectLovDescr: "English", catalogNbr: "101", effdt: "3-4-23"),CourseSummary(subject: "COMPSCI", subjectLovDescr: "Computer Science", catalogNbr: "260", effdt: "4-19-22")]))))))
    }
}

struct SSRGetCoursesResp: Codable {
    let courseSearchResult: CourseSearchResult
    
    enum CodingKeys: String, CodingKey {
        case courseSearchResult = "course_search_result"
    }
}

struct CourseSearchResult: Codable {
    let subjects: Subjects
    
    enum CodingKeys: String, CodingKey {
        case subjects = "subjects"
    }
}

struct Subjects: Codable {
    let subject: Subject
    
    enum CodingKeys: String, CodingKey {
        case subject = "subject"
    }
}

struct Subject: Codable {
    let courseSummaries: CourseSummaries
    
    enum CodingKeys: String, CodingKey {
        case courseSummaries = "course_summaries"
    }
}

struct CourseSummaries: Codable, Hashable {
    let courseSummary: [CourseSummary]
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case courseSummary = "course_summary"
    }
}

struct CourseSummary: Codable, Hashable {
    let subject: String
    let subjectLovDescr: String
    let catalogNbr: String
    let effdt: String
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case subject
        case subjectLovDescr = "subject_lov_descr"
        case catalogNbr = "catalog_nbr"
        case effdt
    }
}

let apiKey = "bd980db66f9ef380f0c808418899dcbc"
