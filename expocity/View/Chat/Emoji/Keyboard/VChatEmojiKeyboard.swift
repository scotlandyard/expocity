import UIKit

class VChatEmojiKeyboard:UIView
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    
    init(controller:CChat)
    {
        super.init(frame:CGRectZero)
        clipsToBounds = true
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        
        addSubview(collectionView)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}