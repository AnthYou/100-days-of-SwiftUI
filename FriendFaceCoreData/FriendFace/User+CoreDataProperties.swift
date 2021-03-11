//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Anthony You on 10/03/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friends: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    
    public var unwrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var unwrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var unwrappedCompany: String {
        company ?? "Unknown company"
    }
    
    public var unwrappedRegistered: Date {
        registered ?? Date()
    }
    
    public var unwrappedAbout: String {
        about ?? "No bio"
    }
    
    public var friendsArray: [User] {
        let set = friends as? Set<User> ?? []
        
        return set.sorted { $0.unwrappedName < $1.unwrappedName }
    }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
