//
//  ContentView.swift
//  GuessTheJam
//
//  Created by Ryan Cummins on 7/6/21.
//

import SwiftUI
struct Player: Identifiable {
    let id = UUID()
    let name: String
    var score: Int = 0
    var isHighlighted: Bool = false
}

struct ContentView: View {
    
    @State var players = [
        Player(name: "Ryan"),
        Player(name: "Katrina"),
        Player(name: "Brad"),
        Player(name: "Mary"),
        Player(name: "Dean"),
        Player(name: "Stacey"),
    ]
    
    
    var body: some View {
        VStack {
            ScrollView {
              HStack {
                ForEach(players) { player in
                    Button(action: {}, label: {
                        Text(player.name)
                    }) // Button
                    .foregroundColor(.red)
//                    .cornerRadius(12)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    Divider()
                }
              }
              .padding()
            }
            .frame(height: 40)
            List(players) { player in
                Button(action: {
                    correctGuessBy(player: player)
                }, label: {
                    HStack {
                        Text(player.name)
                    Divider()
                    Text(String(player.score))
                    }
                }) // Button
//                .cornerRadius(12)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            } // List
            .padding()
            Button {
                nextPlayer()
            } label: {
                HStack {
                    Text("Skip")
                    Spacer()
                    Image("arrow.forward.square")
                }
            }

        } // VStack
    } // body
    
    private func nextPlayer() {
        
    }
    private func correctGuessBy(player: Player) {
//        player.score += 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
