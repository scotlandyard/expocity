import UIKit

class MChatItem
{
    weak var cell:VChatConversationCell?
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
    
    func heightForCollection(width:CGFloat) -> CGFloat
    {
        if width != cellWidth
        {
            cellWidth = width
            cellHeight = heightForCurrentWidth()
            cell?.layoutConstraints()
        }
        
        return cellHeight
    }
}
