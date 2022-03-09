//
//  RemovingOptionals.swift
//  TRFramework
//
//  Created by Ryan Cummins on 10/20/21.
//

import UIKit

class RemovingOptionals: UIViewController {
    
    //MARK: - Lazy
    lazy var collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    //or
    lazy var collectionView2: UICollectionView = makeCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Nil Coalescing
//        let cache = (try? String(contentsOfFile: "cache.txt")) ?? ""
        
//        let friends = UserDefaults.standard.array(forKey: "friends") as? [String] ?? []
        
        //MARK: - Compact Map
//        let numberStrings = ["1", "2", "Three"]
//        let numberInts = numberStrings.compactMap { Int($0) }
//        let urls = urlStrings.compactMap { URL(string: $0) }
//        let definitelyNumbers = maybeNumber.compactMap { $0 }
        
        
    }
    
    func makeCollectionView() -> UICollectionView {
        let config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }


}
