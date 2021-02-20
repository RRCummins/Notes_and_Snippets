# UIKit Object Notes

## Buttons

```swift

```

```swift

```
## ImageViews

```swift

```

## Labels

```swift

```

## Spinners

```swift
private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
```
```swift

```

## TableViews

```swift
private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                    forCellReuseIdentifier: "cell")
        return tableView
    }()

tableView.delegate = self
tableView.dataSource = self

extension ViewController: UITableViewDelegate, UITableViewDatasource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

```

## CollectionViews

```swift

```