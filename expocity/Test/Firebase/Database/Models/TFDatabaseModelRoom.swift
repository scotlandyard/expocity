import XCTest
@testable import expocity

class TFDatabaseModelRoom:XCTestCase
{
    private let kSnapshot:[String:Any] = [
        "presentation":1,
        "owner":"John Test",
        "name":"My fancy room",
        "created":1475541121.581116,
        "access":1
    ]
    
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
        
        XCTAssertEqual(access, rawAccess, "Invalid access")
        XCTAssertEqual(name, roomName, "Invalid name")
        XCTAssertEqual(owner, roomOwner, "Invalid owner")
    }
    
    func testSnapshot()
    {
        let snapshotRawPresentation:Int = kSnapshot["presentation"] as! Int
        let snapshotOwner:String = kSnapshot["owner"] as! String
        let snapshotName:String = kSnapshot["name"] as! String
        let snapshotCreated:TimeInterval = kSnapshot["created"] as! TimeInterval
        let snapshotRawAccess:Int = kSnapshot["access"] as! Int
        let snapshotPresentation:FDatabaseModelRoom.Presentation = FDatabaseModelRoom.Presentation(
            rawValue:snapshotRawPresentation)!
        let snapshotAccess:FDatabaseModelRoom.Access = FDatabaseModelRoom.Access(
            rawValue:snapshotRawAccess)!
        
        let firebaseRoom:FDatabaseModelRoom = FDatabaseModelRoom(
            snapshot:kSnapshot)
        
        let roomPresentation:FDatabaseModelRoom.Presentation = firebaseRoom.presentation
        let roomOwner:String = firebaseRoom.owner
        let roomName:String = firebaseRoom.name
        let roomCreated:TimeInterval = firebaseRoom.created
        let roomAccess:FDatabaseModelRoom.Access = firebaseRoom.access
        
        XCTAssertEqual(snapshotPresentation, roomPresentation, "Invalid presentation")
        XCTAssertEqual(snapshotOwner, roomOwner, "Invalid owner")
        XCTAssertEqual(snapshotName, roomName, "Invalid name")
        XCTAssertEqual(snapshotCreated, roomCreated, "Invalid created timestamp")
        XCTAssertEqual(snapshotAccess, roomAccess, "Invalid access")
    }
}
