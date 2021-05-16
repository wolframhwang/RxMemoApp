//
//  MemoListViewModel.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel : CommonViewModel{
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
