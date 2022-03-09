//
//  SixTryApp.swift
//  SixTry
//
//  Created by Ryan Cummins on 3/9/22.
//

import SwiftUI

@main
struct SixTryApp: App {
    @State var dm = SixTryDataModel()
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dm)
        }
    }
}
