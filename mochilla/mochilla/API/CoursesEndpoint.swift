//
//  CoursesEndpoint.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import Foundation

struct CoursesEndpoint {
    static let baseUrl = "https://streamer.oit.duke.edu/curriculum/courses/subject/"
    
    static let delimiter = "%20"
    
    static let accessToken = "?access_token=bd980db66f9ef380f0c808418899dcbc"
    
    // for reference
    // AAAS%20-%20African%20%26%20African%20Amer%20Studies?access_token=bd980db66f9ef380f0c808418899dcbc"
    
    static let apiKey = "bd980db66f9ef380f0c808418899dcbc"
    
    enum QueryType: String {
        case subject
    }

    static func path(courseType: String) -> String {
//        let url = "\(baseUrl)/\(queryType.rawValue)"
//        let key = "appid=\(apiKey)"
//        let units = "units=imperial"
//        let queryParameters = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        //return "\(url)?\(units)&\(queryParameters)&\(key)"
        return baseUrl + courseType.replacingOccurrences(of: " ", with: delimiter) + accessToken
    }
}
