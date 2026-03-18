//
//  DinoappApp.swift
//  Dinoapp
//
//  Created by JOSE ALEJANDRO OVALLE VILLAMIL on 13/03/26.
//

import SwiftUI

@main
struct DinoappApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            AppCoordinator(appState: appState)
        }
    }
}
