import Foundation

class MHome
{
    let items:[MHomeItem]
    weak var itemTitle:MHomeItemTitle!
    weak var itemAccess:MHomeItemAccess!
    
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
    
    func room() -> FDatabaseModelRoom
    {
        let access:FDatabaseModelRoom.Access = itemAccess.access
        let userId:String = MSession.sharedInstance.user!.userId!
        var title:String = itemTitle.title
        
        if title.isEmpty
        {
            title = NSLocalizedString("MHome_noTitle", comment:"")
        }
        
        let room:FDatabaseModelRoom = FDatabaseModelRoom(
            name:title,
            access:access,
            owner:userId)
        
        return room
    }
}
