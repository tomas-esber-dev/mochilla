//
//  SettingsViewModel.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
