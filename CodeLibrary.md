# Code Snippets

## Dismissing the Keyboard on a TextField

<pre><code>

@IBOutlet var textField: UITextField!
@IBOutlet var textField2: UITextField!

// Set the delegate to self on each text field
override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        textField2.delegate = self
}



extension UIViewController {
  
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField2.resignFirstResponder()
        return true
    }

   /**
    * Called when the user click on the view (outside the UITextField).
    */
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     self.view.endEditing(true)
   }
}
// From https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
</code></pre>

## Next Item Here