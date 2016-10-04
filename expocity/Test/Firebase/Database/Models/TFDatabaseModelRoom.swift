import XCTest
@testable import expocity

class TFDatabaseModelRoom:XCTestCase
{
    //MARK: -
    
    func testModelJson()
    {
        let name:String = "MyRoom"
        let access:FDatabaseModelRoom.Access = FDatabaseModelRoom.Access.freeJoin
        let owner:String = "123456"
        let nameKey:String = FDatabaseModelRoom.Property.name.rawValue
        let accessKey:String = FDatabaseModelRoom.Property.access.rawValue
        let ownerKey:String = FDatabaseModelRoom.Property.owner.rawValue
        
        let firebaseRoom:FDatabaseModelRoom = FDatabaseModelRoom(
            name:name,
            access:access,
            owner:owner)
        
        let json:[String:Any] = firebaseRoom.modelJson()
        let roomName:String? = json[nameKey] as? String
        let roomOwner:String? = json[ownerKey] as? String
        let roomRawAccess:Int? = json[accessKey] as? Int
        
        XCTAssertNotNil(roomRawAccess, "Invalid raw access")
        
        let rawAccess:FDatabaseModelRoom.Access? = FDatabaseModelRoom.Access(rawValue:roomRawAccess!)
        
        XCTAssertTrue(access == rawAccess, "Invalid access")
        XCTAssertTrue(name == roomName, "Invalid name")
        XCTAssertTrue(owner == roomOwner, "Invalid owner")
    }
}
