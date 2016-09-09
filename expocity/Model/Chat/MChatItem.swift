import UIKit

class MChatItem
{
    let reusableIdentifier:String
    var cellWidth:CGFloat
    var cellHeight:CGFloat
    
    init(reusableIdentifier:String)
    {
        self.reusableIdentifier = reusableIdentifier
        cellWidth = 0
        cellHeight = 0
    }
    
    //MARK: public
    
    func heightForCurrentWidth() -> CGFloat
    {
        return 0
    }
    
    func heightForCollection(collection:UICollectionView) -> CGFloat
    {
        let width:CGFloat = collection.bounds.maxX
        
        if width != cellWidth
        {
            cellWidth = width
            cellHeight = heightForCurrentWidth()
            
            collection.collectionViewLayout.invalidateLayout()
        }
        
        return cellHeight
    }
}