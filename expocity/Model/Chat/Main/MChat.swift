import Foundation

class MChat
{
    var title:String
    var items:[MChatItem]
    var displayOption:MChatDisplayOptionsItem
    
    init(title:String)
    {
        self.title = title
        items = []
        displayOption = MChatDisplayOptionsItemFill()
    }
}