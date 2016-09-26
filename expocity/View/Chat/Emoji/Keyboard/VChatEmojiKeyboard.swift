import UIKit

class VChatEmojiKeyboard:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    let model:MChatEmojiKeyboard
    
    init(controller:CChat)
    {
        model = MChatEmojiKeyboard()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        
        addSubview(collectionView)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MChatEmojiKeyboardItem
    {
        let item:MChatEmojiKeyboardItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collection del
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MChatEmojiKeyboardItem = modelAtIndex(indexPath)
        let cell:VChatEmojiKeyboardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VChatEmojiKeyboardCell.reusableIdentifier(),
            for:indexPath) as! VChatEmojiKeyboardCell
        cell.config(item)
        
        return cell
    }
}
