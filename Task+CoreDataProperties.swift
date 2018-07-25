//
//  Task+CoreDataProperties.swift
//  pomodoro
//
//  Created by Yasuteru on 2018/07/25.
//  Copyright © 2018年 reo. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var deadLine: NSDate?
    @NSManaged public var comment: String?

}
