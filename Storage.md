# Storage Notes

---

## User Defaults

<pre><code>
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

---

## Codable

### Creating a custom plist

This is very memory intensive. You have to load up to entire plist to use it. Shouldn't be used for more than 100kb of data.

<pre><code>
// Make sure the conforms to eight the Encodable and Decodable protocaols or as of Swift 4 just use Codable
// Create the class in seperate cocoa touch file

class Item: Codable {
  
  var title: String = ""
  var done: Bool = false
  
}

// You could use this to create other plist files
let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

func saveItems(andReload: Bool) {
  
  let encoder = PropertyListEncoder()
  
  do {
    let data = try encoder.encode(itemArray)
    try data.write(to: dataFilePath!)
  } catch {
    print("Error encoding item array, \(error)")
  }
  if andReload == true {
    self.tableView.reloadData()
  }
}

func loadItems() {
  
  if let data = try? Data(contentsOf: dataFilePath!) {
    let decoder = PropertyListDecoder()
    do {
      itemArray = try decoder.decode([Item].self, from: data)
    } catch {
      print("There was an error decoding data, \(error)")
    }
  }
}
</code></pre>

---

## SQLite

---

## Core Data

### Notes
- Enity - in CoreData is just like a Class in Codable, it is also like a Table of data.
- NSPersistantContainer - This is your CoreData DB. It is acutally a SQLite DB. Can be another type of DB like XML, etc.
- Context  - Is a temporary area where you can put your data until you are ready to save it.  Also known as a scratch pad.

### Codegen Options
- None - Hardest method, this creates no linking code
- Class Definition - Easiest method, xcode creates all the class code and hides it deep in the files structure.
- Category/Extension - Most used method, user creates the classes with the exact names of the coreData DB and xcode links them up.

---
## CRUD
### Create

### Read

### Update

### Delete

## Realm