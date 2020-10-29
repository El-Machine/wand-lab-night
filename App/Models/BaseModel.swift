//
//  BaseModel.swift
//  Heap
//
//  Created by Alex Kozin on 17.01.16.
//  Copyright © 2019 Alex Kozin. All rights reserved.
//

import CloudKit

class BaseModel: NSObject {

    var record: CKRecord?

    var recordID: CKRecord.ID? {
        record?.recordID
    }
    var recordName: String? {
        record?.recordID.recordName
    }

    var key: String {
        recordName!
    }

    required init(_ record: CKRecord? = nil) {
        super.init()

        self.record = record
    }

    func changedKeys() -> [CKRecord.FieldKey]? {
        record?.changedKeys()
    }

    func type() -> String {
        Utils.string(Self.self).components(separatedBy: "_").first!
    }

    @discardableResult
    func createRecordIfNeed(id: CKRecord.ID? = nil) -> CKRecord {
        var record = self.record
        if record == nil {
            if let id = id {
                record = CKRecord(recordType: type(), recordID: id)
            } else {
                record = CKRecord(recordType: type())
            }
            self.record = record
        }

        return record!
    }

    override func isEqual(_ object: Any?) -> Bool {
        recordName == (object as? BaseModel)?.recordName
    }

}

extension BaseModel {

    func inBox() -> CKRecord {
        createRecordIfNeed()
    }

}

extension Item where Self: BaseModel {

    var cellIdentifier: String? {
        Utils.string(Self.self)
    }
}
