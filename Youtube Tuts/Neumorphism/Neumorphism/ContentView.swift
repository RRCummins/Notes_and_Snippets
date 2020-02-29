//
//  ContentView.swift
//  Neumorphism
//
//  Created by Ryan Cummins on 2/26/20.
//  Copyright © 2020 Them Rhinos. All rights reserved.
//

import SwiftUI

extension Color {
    static let offWhite = Color("offWhite")
    static let darkStart = Color("darkStart")
    static let darkEnd = Color("darkEnd")
    static let darkGrey = Color("darkGrey")
    static let lightStart = Color("lightStart")
    static let lightEnd = Color("lightEnd")
    
//    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
//    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
//    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
//    static let darkGrey = Color(red: 40 / 255, green: 40 / 255, blue: 50 / 255)
//    static let lightStart = Color(red: 60 / 255, green: 220 / 255, blue: 240 / 255)
//    static let lightEnd = Color(red: 30 / 255, green: 110 / 255, blue: 120 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct DarkBackground<S: Shape>: View {
    var isHighlighted: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var shape: S
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.darkGrey, Color.darkEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                }
            } else {
                if isHighlighted {
                    shape
                        .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                        .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                        .shadow(color: Color.darkEnd, radius: 10, x: 5, y: 5)
                        .shadow(color: Color.darkStart, radius: 10, x: -5, y: -5)
                } else {
                    shape
                        .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                        .overlay(shape.stroke(LinearGradient(Color.darkGrey, Color.darkEnd), lineWidth: 4))
                        .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                        .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                }
            }
        }
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .padding(30)
        .contentShape(Circle())
        .background(
            Group {
                if configuration.isPressed {
                    Circle()
                        .fill(Color.offWhite)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: -2, y: -2)
                                .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                        )
                } else {
                    Circle()
                        .fill(Color.offWhite)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                }
            }
        )
    }
}

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .padding(30)
        .contentShape(Circle())
            .background(DarkBackground(isHighlighted: configuration.isPressed, shape: Circle()))
        .animation(nil)
    }
}

struct DarkToggleSyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        })
        {
            configuration.label
            .padding(30)
            .contentShape(Circle())
        }
        .background(DarkBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct DarkRectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(RoundedRectangle(cornerRadius: 15))
            .background(DarkBackground(isHighlighted: configuration.isPressed, shape: RoundedRectangle(cornerRadius: 15)))
            .animation(nil)
    }
}

struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle()))
            .animation(nil)
    }
}

struct ColorfulToggleSyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        })
        {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        }
        .background(ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct ContentView: View {
    @State private var isToggled = false
    
    var body: some View {
        ZStack {
            LinearGradient(Color.darkStart, Color.darkEnd)
            VStack(spacing: 40) {
                Button(action: {
                    print("Button Tapped")
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
                .buttonStyle(DarkButtonStyle())
                
                Button(action: {
                    print("Button Tapped")
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
                .buttonStyle(DarkRectButtonStyle())
                
                Button(action: {
                    print("Button Tapped")
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
                .buttonStyle(ColorfulButtonStyle())
                
                Toggle(isOn: $isToggled) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
                .toggleStyle(ColorfulToggleSyle())
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}



/// [How to Use Neuromorphism in SwiftUI](https://youtu.be/z3tJdxwlo_Y?list=WL)
