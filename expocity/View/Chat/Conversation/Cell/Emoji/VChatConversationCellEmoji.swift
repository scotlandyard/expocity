import UIKit

class VChatConversationCellEmoji:VChatConversationCell
{
    weak var imageView:UIImageView!
    private let kMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "marginHorizontal":kMarginHorizontal]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(marginHorizontal)-[imageView]-(marginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MChatItem, controller:CChat)
    {
        super.config(model:model, controller:controller)
    }
}
