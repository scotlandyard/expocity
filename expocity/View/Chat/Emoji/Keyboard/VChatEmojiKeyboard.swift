import UIKit

class VChatEmojiKeyboard:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    weak var layoutHeight:NSLayoutConstraint!
    let model:MChatEmojiKeyboard
    private let kBorderHeight:CGFloat = 1
    private let kMaxHeight:CGFloat = 200
    
    init(controller:CChat)
    {
        model = MChatEmojiKeyboard()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.bubbleMine()
        border.translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        
        addSubview(border)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "border":border,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "borderHeight":kBorderHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[border(borderHeight)]-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
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
        let item:MChatEmojiKeyboardItem = modelAtIndex(index:indexPath)
        let cell:VChatEmojiKeyboardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VChatEmojiKeyboardCell.reusableIdentifier(),
            for:indexPath) as! VChatEmojiKeyboardCell
        cell.config(model:item)
        
        return cell
    }
}
