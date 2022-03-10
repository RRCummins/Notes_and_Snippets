//
//  SixTryDataModel.swift
//  SixTry
//
//  Created by Ryan Cummins on 3/9/22.
//

import SwiftUI

class SixTryDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    
    var keyColors = [String : Color]()
    
    init() {
        newGame()
    }
    
    //MARK: - Setup
    func newGame() {
        populateDefaults()
    }
    
    func populateDefaults() {
        guesses = []
        for index in 0...5 {
            guesses.append(Guess(index: index))
        }
        // reset keyboard colors
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors[String(char)] = .unused
        }
    }
    
    //MARK: - Game Play
    func addToCurrentWord(_ letter: String) {
        
    }
    
    func enterWord() {
        
        
    }
    
    func removeLetterFromCurrentWord() {
        
    }
}
