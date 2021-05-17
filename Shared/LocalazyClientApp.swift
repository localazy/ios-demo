//
//  LocalazyClientApp.swift
//  Shared
//
//  Created by Jaroslav Pulik on 01/04/2021.
//

import SwiftUI

@main
struct LocalazyClientApp: App {
    
    init() {
        Bundle.swizzleLocalizationWithLocalazy()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
