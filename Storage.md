# Storage Notes

## User Defaults

<pre><>code
// Lesson 226 explains UserDefaults
// Lesson 227 explains Singletons
// These are Singletons
var defaults = UserDefaults.standard
let sharedURLSession = URLSession.shared

let dictionaryKey = "MyDictionary"


defaults.set(0.24, forKey: "Volume")
defaults.set(true, forKey: "MusicOn")
defaults.set("Ryan", forKey: "PlayerName")
defaults.set(Date(), forKey: "AppLastOpenedByUser")
let array = [1, 2, 3,]
let dictionary = ["name" : "Ryan",]


defaults.set(array, forKey: "MyArray")
defaults.set(dictionary, forKey: dictionaryKey)



let appLastOpened = defaults.object(forKey: "AppLastOpenedByUser")
let volume = defaults.float(forKey: "Volume")
let myDictionary = defaults.dictionary(forKey: dictionaryKey)
let myArray = defaults.array(forKey: "MyArray") as! [Int]
</code></pre>


## plist







## Core Data
