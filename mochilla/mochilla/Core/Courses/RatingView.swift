//
//  RatingView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    @ObservedObject var viewModel = UserCoursesManagerModel()
    var course: Course
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    let auth = try? AuthenticationManager.shared.getAuthenticatedUser().uid
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                        viewModel.addCourse(course: DBCourse(courseName: course.subject, courseCode: course.catalogNumber, rating: rating), toUserWithID: auth ?? "53rXnyFvnhPX6S4MQAPfa7HscJ92")
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3), course: Course(subject: "Engineering", catalogNumber: "202", effectiveDate: "4-9-20", rating: 2))
    }
}
