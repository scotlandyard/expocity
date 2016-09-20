import Foundation

class MChatDisplayAnnotations
{
    var items:[MChatDisplayAnnotationsItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func addAnnoation() -> MChatDisplayAnnotationsItem
    {
        let newItem:MChatDisplayAnnotationsItem = MChatDisplayAnnotationsItem()
        items.append(newItem)
        
        return newItem
    }
}