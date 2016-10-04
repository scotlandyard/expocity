import Foundation

class MChat
{
    var title:String
    var items:[MChatItem]
    var displayOption:MChatDisplayOptionsItem
    let annotations:MChatDisplayAnnotations
    
    init(firebaseRoom:FDatabaseModelRoom)
    {
        title = ""
        items = []
        displayOption = MChatDisplayOptionsItemFill()
        annotations = MChatDisplayAnnotations()
    }
}
