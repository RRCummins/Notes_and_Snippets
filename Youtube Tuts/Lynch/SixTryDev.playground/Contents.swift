import UIKit

var commonWords = [String]()

if let words = Bundle.main.url(forResource: "words", withExtension: "txt") {
    if let startWords = try? String(contentsOf: words) {
        commonWords = startWords.components(separatedBy: "\n")
    } else {
        print("Couldn't parse the words")
    }
} else {
    print("File not found")
}

print(commonWords.count)

let removeSet = CharacterSet(charactersIn: "'.-/ABCDEFGHIJKLMNOPQRSTUVWXYZ")
let fiveLetterWords = commonWords
    .filter { $0.rangeOfCharacter(from: removeSet) == nil }
    .filter { $0.count == 5 }
    .map { $0.uppercased() }

print(fiveLetterWords.count)
print(fiveLetterWords)
