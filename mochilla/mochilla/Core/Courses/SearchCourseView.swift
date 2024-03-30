//
//  SearchCourseView.swift
//  mochilla
//
//  Created by Tomas Esber on 3/29/24.
//

import SwiftUI

struct SearchCourseView: View {
    @State private var selectedItem = 0
    @State private var showCourseListings = false
    @EnvironmentObject var courseLoader: CourseLoader
    @EnvironmentObject var courseStore: CourseStore
    
    let offerings = SearchCourseViewModel.listOfferings()
        
    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $selectedItem, label: Text("Select an item")) {
                    ForEach(0 ..< offerings.count, id: \.self) {
                        Text(offerings[$0].courseName)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
//                Text("You selected: \(offerings[selectedItem].courseName)")
//                    .padding()
                Button(action: {showCourseListings = true}) {
                    Text("Find Courses")
                }
            }
            .padding()
            .sheet(isPresented: $showCourseListings, onDismiss: {
                courseStore.wipeCourseStore()
                showCourseListings = false
            }) {
                NavigationView {
                    CourseView(courseName: offerings[selectedItem].courseCode + " - " + offerings[selectedItem].courseName)
                        .environmentObject(courseLoader)
                        .environmentObject(courseStore)
                }
                .onAppear {
                    courseStore.wipeCourseStore()
                }
            }
        }
    }
}

struct SearchCourseView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCourseView()
            .environmentObject(CourseLoader(apiClient: MockCoursesAPIClient()))
            .environmentObject(CourseStore())
    }
}
