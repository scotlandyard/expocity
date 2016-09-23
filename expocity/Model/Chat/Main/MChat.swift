import Foundation

class MChat
{
    var title:String
    var items:[MChatItem]
    var displayOption:MChatDisplayOptionsItem
    let annotations:MChatDisplayAnnotations
    
    init(title:String)
    {
        self.title = title
        items = []
        displayOption = MChatDisplayOptionsItemFill()
        annotations = MChatDisplayAnnotations()
    }
}