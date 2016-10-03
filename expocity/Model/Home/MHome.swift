import Foundation

class MHome
{
    let items:[MHomeItem]
    private weak var itemTitle:MHomeItemTitle!
    private weak var itemAccess:MHomeItemAccess!
    
    init()
    {
        let itemTitle:MHomeItemTitle = MHomeItemTitle()
        let itemAccess:MHomeItemAccess = MHomeItemAccess()
        let itemCreate:MHomeItemCreate = MHomeItemCreate()
        self.itemAccess = itemAccess
        self.itemTitle = itemTitle
        
        items = [
            itemTitle,
            itemAccess,
            itemCreate
        ]
    }
    
    //MARK: public
    
    func chat() -> MChat
    {
        var title:String = itemTitle.title
        
        if title.isEmpty
        {
            title = NSLocalizedString("MHome_noTitle", comment:"")
        }
        
        let model:MChat = MChat(title:title)
        
        return model
    }
}
