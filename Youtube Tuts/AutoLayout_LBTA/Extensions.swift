//
//  Extensions.swift
//  Field Day
//
//  Created by Ryan Cummins on 11/20/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit


//MARK: - UIView: AutoLayout
extension UIView {
  
  func pin(to superview: UIView) {
    translatesAutoresizingMaskIntoConstraints                             = false
    topAnchor.constraint(equalTo: superview.topAnchor).isActive           = true
    leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive   = true
    trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive     = true
  }
  
  func fillSuperView() {
    anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, center: nil)
  }
  
  func anchorSize(to view: UIView) {
    widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
  }
  
  func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, center: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, cornerRadius: CGFloat = .zero) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive              = true
    }
    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive     = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive    = true
    }
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
    }
    if let center = center {
      centerXAnchor.constraint(equalTo: center).isActive                              = true
    }
    
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive                    = true
    }
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive                  = true
    }
    
    if cornerRadius != 0 {
      layer.cornerRadius = cornerRadius
    }
    
  }
}


  //MARK: - UITableView: scrollToBottomRow
extension UITableView {
  //Found at https://stackoverflow.com/questions/33705371/how-to-scroll-to-the-exact-end-of-the-uitableview
    func scrollToBottomRow() {
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else { return }

            // Make an attempt to use the bottom-most section with at least one row
            var section = max(self.numberOfSections - 1, 0)
            var row = max(self.numberOfRows(inSection: section) - 1, 0)
            var indexPath = IndexPath(row: row, section: section)

            // Ensure the index path is valid, otherwise use the section above (sections can
            // contain 0 rows which leads to an invalid index path)
            while !self.indexPathIsValid(indexPath) {
                section = max(section - 1, 0)
                row = max(self.numberOfRows(inSection: section) - 1, 0)
                indexPath = IndexPath(row: row, section: section)

                // If we're down to the last section, attempt to use the first row
                if indexPath.section == 0 {
                    indexPath = IndexPath(row: 0, section: 0)
                    break
                }
            }

            // In the case that [0, 0] is valid (perhaps no data source?), ensure we don't encounter an
            // exception here
            guard self.indexPathIsValid(indexPath) else { return }

            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
    }
}
