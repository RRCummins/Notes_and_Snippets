# Terms

## Operators

### Ternery Operator

<pre><code>
//Ternery operator ==>
    // value = condition ? valueIfTure : valueIfFalse
    cell.accessoryType = item.done ? .checkmark : .none
</code></pre>

### Not Operator => !not

<pre><code>
 Using the not operator
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
</code></pre>

## Parts of a project
- (UIApplication.shared.delegate as! AppDelegate) - creates a singleton object of the AppDelegate for the current app

## Tuples
- A tuple type is a comma-separated list of types, enclosed in parentheses.
- Two interrelated pieces of data grouped together. Can be different data types
- https://docs.swift.org/swift-book/ReferenceManual/Types.html#grammar_tuple-type

### Using Tuples

<pre><code>
let tuple1 = ("Ryan", 12)
tuple1.0 //"Ryan"
tuple1.1 // 34

let tuple2 = (name: "Ryan", age: 34)
tuple2.name //"Ryan"
tuple2.age // 34

let tuple3: (name: String, age: Int)
tuple3.name = "Ryan"
tuple3.age = 34
tuple3.name //"Ryan"
tuple3.age // 34

var someTuple = (top: 10, bottom: 12)  // someTuple is of type (top: Int, bottom: Int)
someTuple = (top: 4, bottom: 42) // OK: names match
someTuple = (9, 99)              // OK: names are inferred
someTuple = (left: 5, right: 5)  // Error: names don't match
</code></pre>
