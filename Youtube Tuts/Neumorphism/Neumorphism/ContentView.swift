//
//  ContentView.swift
//  Neumorphism
//
//  Created by Ryan Cummins on 2/26/20.
//  Copyright © 2020 Them Rhinos. All rights reserved.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 55, green: 225 / 255, blue: 235 / 255)
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .padding(30)
        .background(
            Circle()
                .fill(Color.offWhite)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        )
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.offWhite
            
            Button(action: {
                print("Button Tapped")
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.gray)
            }
        .buttonStyle(SimpleButtonStyle())
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct ContentView: View {
//    var body: some View {
//        ZStack {
//            Color.offWhite
//
//            RoundedRectangle(cornerRadius: 25)
//                .fill(Color.offWhite)
//                .frame(width: 300, height: 300)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



///https://youtu.be/z3tJdxwlo_Y?list=WL
