import Foundation

class MChatDisplayAnnotations
{
    var items:[MChatDisplayAnnotationsItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func addAnnotation() -> MChatDisplayAnnotationsItem
    {
        let newItem:MChatDisplayAnnotationsItem = MChatDisplayAnnotationsItem()
        items.append(newItem)
        
        return newItem
    }
    
    func removeAnnotation(item:MChatDisplayAnnotationsItem)
    {
        
    }
}