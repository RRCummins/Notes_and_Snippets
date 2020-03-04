//
//  ContentView.swift
//  Project1SwiftUI
//
//  Created by Ryan Cummins on 2/29/20.
//  Copyright © 2020 Them Rhinos. All rights reserved.
//

import Combine
import SwiftUI

class DataSource: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Hello, World!")
            }.navigationBarTitle("Storm Viewer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
