# UIKit Object Notes

## Buttons

```swift
private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
```

```swift
private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
```
## ImageViews

```swift

```

## Labels

```swift
private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.test = "example"
        return label
    }()

```

## Spinners

```swift
private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()

    view.addSubview(spinner)
    spinner.startAnimating()

    spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    spinner.center = view.center
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
### Compositional Layout

```swift
private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return SomeViewController.createSectionLayout(section: sectionIndex)
        }
    )
//---------------------------------------------
// Setup like a vertical Table View
private static func createSectionLayout(section: Int) ->  NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(120)),
            subitem: item,
            count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
// Or
// Setup for horizontal scroll
private static func createSectionLayout(section: Int) ->  NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(120)),
            subitem: item,
            count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
//----------------------------------------------
private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }

extension SomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    
}
```

## Cell Delegate Pattern

### Above Cell's VC
```swift
protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState {
    case following, not_following
}

struct UserRelationship {
    let userName: String
    let name: String
    let type: FollowState
}
```

### In the Cell's VC
```swift
static let identifier = "UserFollowTableViewCell"
    
public weak var delegate: UserFollowTableViewCellDelegate?
    
private var model: UserRelationship?

// After override init()
// After override viewDidLayoutSubviews()
// After override prepareForReuse()

@objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }

public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.userName
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
```

### In Parent List VC
```swift

private let data: [UserRelationship]
    
private let tableView: UITableView = {
    let tv = UITableView()
    tv.register(UserFollowTableViewCell.self,
                forCellReuseIdentifier: UserFollowTableViewCell.identifier)
    return tv
}()

init(data: [UserRelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
}

// In TableView Extension with TVDatasource and TVDelegate
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier,
                                                 for: indexPath) as! UserFollowTableViewCell
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
}

// Another Extension
extension ListViewController: UserFollowTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserRelationship) {
        switch model.type {
        case .following:
            // perform firebase update to unfollow
            print("Unfollowing")
        case .not_following:
            // perform firebase update to follow
            print("Following")
        
        }
    }
}
```

### In initial VC that calls ListVC 
```swift
func didTapFollowButton() {
    var mockData = [UserRelationship]()
            for x in 0..<10 {
                mockData.append(UserRelationship(userName: "@Joe", name: "Joe Smith", type: x % 2 == 0 ? .following : .not_following))
            }
            let vc = ListViewController(data: mockData)
            vc.title = "Following"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
}
```