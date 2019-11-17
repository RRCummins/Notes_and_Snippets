# UICollectionView & UICollectionViewCell

## UICollectionViewCell
### To configure the appearance of your cell, add the views needed to present the data item’s content as subviews to the view in the contentView property. Do not directly add subviews to the cell itself. The cell manages multiple layers of content, of which the content view is only one. In addition to the content view, the cell manages two background views that display the cell in its selected and unselected states.

### You typically do not create instances of this class yourself. Instead, you register your specific cell subclass (or a nib file containing a configured instance of your class) with the collection view object. When you want a new instance of your cell class, call the dequeueReusableCell(withReuseIdentifier:for:) method of the collection view object to retrieve one.

