//
//  Memo.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation
import RxDataSources//Data Source에 저장되는 모든것들은 Identifiable!
import CoreData
import RxCoreData

struct Memo : Equatable, IdentifiableType{
    var content: String//내용
    var insertDate: Date//날짜
    var identity: String//메모 구분자
    init(content: String, insertDate: Date = Date()){
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}

extension Memo: Persistable {
    public static var entityName: String {
        return "Memo"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(insertDate, forKey: "insertDate")
        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")
        
        do {
            try entity.managedObjectContext?.save()
        }catch {
            print(error)
        }
    }
}
