import XCTest
@testable import expocity

class TMChat:XCTestCase
{
    private let kRoomSnapshot:[String:Any] = [
        "presentation":1,
        "owner":"123456",
        "name":"My fancy room",
        "created":1475541121.581116,
        "access":1
    ]
    
    //MARK: -
    
    func testFirebaseRoom()
    {
        let snapshotRawPresentation:Int = kRoomSnapshot["presentation"] as! Int
        let snapshotOwner:String = kRoomSnapshot["owner"] as! String
        let snapshotName:String = kRoomSnapshot["name"] as! String
        let snapshotCreated:TimeInterval = kRoomSnapshot["created"] as! TimeInterval
        let snapshotRawAccess:Int = kRoomSnapshot["access"] as! Int
        let snapshotPresentation:FDatabaseModelRoom.Presentation = FDatabaseModelRoom.Presentation(
            rawValue:snapshotRawPresentation)!
        let snapshotAccess:FDatabaseModelRoom.Access = FDatabaseModelRoom.Access(
            rawValue:snapshotRawAccess)!
        
        let firebaseRoom:FDatabaseModelRoom = FDatabaseModelRoom(snapshot:kRoomSnapshot)
        let chat:MChat = MChat(firebaseRoom:firebaseRoom)
        
        let chatPresentation:FDatabaseModelRoom.Presentation = chat.presentation
        let chatOwner:String = chat.owner
        let chatName:String = chat.title
        let chatCreated:TimeInterval = chat.created
        let chatAccess:FDatabaseModelRoom.Access = chat.access
        
        XCTAssertEqual(snapshotPresentation, chatPresentation, "Invalid presentation")
        XCTAssertEqual(snapshotOwner, chatOwner, "Invalid owner")
        XCTAssertEqual(snapshotName, chatName, "Invalid title")
        XCTAssertEqual(snapshotCreated, chatCreated, "Invalid created timestamp")
        XCTAssertEqual(snapshotAccess, chatAccess, "Invalid access")
    }
    
    func testChatOwner()
    {
        let userId:String = MSession.sharedInstance.user!.userId!
        let snapshot:[String:Any] = [
            "owner":userId
        ]
        
        let firebaseRoom:FDatabaseModelRoom = FDatabaseModelRoom(
            snapshot:snapshot)
        let chat:MChat = MChat(firebaseRoom:firebaseRoom)
        
        let meOwner:Bool = chat.meOwner
        
        XCTAssertTrue(meOwner, "Chat owner not working")
    }
    
    func testChatNotOwner()
    {
        let snapshot:[String:Any] = [
            "owner":"123456"
        ]
        
        let firebaseRoom:FDatabaseModelRoom = FDatabaseModelRoom(
            snapshot:snapshot)
        let chat:MChat = MChat(firebaseRoom:firebaseRoom)
        
        let meOwner:Bool = chat.meOwner
        
        XCTAssertFalse(meOwner, "Chat owner not working")
    }
}
