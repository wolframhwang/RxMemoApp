//
//  Memo.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation

struct Memo : Equatable {
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
