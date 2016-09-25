import UIKit

class VChatEmojiKeyboard:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    let model:MChatEmojiKeyboardItem
    
    init(controller:CChat)
    {
        model = MChatEmojiKeyboardItem()
        
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
    
    //MARK: collection del
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 0
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 0
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        return nil
    }
}