import Foundation

class MChat
{
    let roomId:String
    var title:String
    var items:[MChatItem]
    var displayOption:MChatDisplayOptionsItem
    let annotations:MChatDisplayAnnotations
    
    init(roomId:String)
    {
        self.roomId = roomId
        items = []
        displayOption = MChatDisplayOptionsItemFill()
        annotations = MChatDisplayAnnotations()
    }
}
