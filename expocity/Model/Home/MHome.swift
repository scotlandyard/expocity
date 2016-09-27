import Foundation

class MHome
{
    let items:[MHomeItem]
    private weak var itemTitle:MHomeItemTitle!
    
    init()
    {
        let itemTitle:MHomeItemTitle = MHomeItemTitle()
        let itemCreate:MHomeItemCreate = MHomeItemCreate()
        self.itemTitle = itemTitle
        
        items = [
            itemTitle,
            itemCreate
        ]
    }
    
    //MARK: public
    
    func chat() -> MChat
    {
        let title:String = itemTitle.title
        let model:MChat = MChat(title:title)
        
        return model
    }
}
