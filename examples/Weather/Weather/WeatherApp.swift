//
//  WeatherApp.swift
//  Weather
//
//  Created by Victor Gil Alejandria on 13/02/2026.
//

import SwiftUI
import SwiftData

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherModule.build()
        }
    }
}
