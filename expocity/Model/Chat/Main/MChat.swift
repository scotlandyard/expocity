import Foundation

class MChat
{
    var title:String
    var items:[MChatItem]
    
    init(title:String)
    {
        self.title = title
        items = []
    }
}