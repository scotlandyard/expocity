import Foundation

class MChat
{
    var title:String
    var access:FDatabaseModelRoom.Access
    var presentation:FDatabaseModelRoom.Presentation
    var items:[MChatItem]
    var displayOption:MChatDisplayOptionsItem
    let annotations:MChatDisplayAnnotations
    let owner:String
    let created:TimeInterval
    let meOwner:Bool
    
    init(firebaseRoom:FDatabaseModelRoom)
    {
        title = firebaseRoom.name
        access = firebaseRoom.access
        presentation = firebaseRoom.presentation
        items = []
        displayOption = MChatDisplayOptionsItemFill()
        annotations = MChatDisplayAnnotations()
        owner = firebaseRoom.owner
        created = firebaseRoom.created
        
        if owner == MSession.sharedInstance.user!.userId!
        {
            meOwner = true
        }
        else
        {
            meOwner = false
        }
    }
}
