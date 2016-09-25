import UIKit

class VChatEmojiKeyboard:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    let model:MChatEmojiKeyboard
    
    init(controller:CChat)
    {
        model = MChatEmojiKeyboard()
        
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
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MChatEmojiKeyboardItem
    {
        let item:MChatEmojiKeyboardItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collection del
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        return nil
    }
}