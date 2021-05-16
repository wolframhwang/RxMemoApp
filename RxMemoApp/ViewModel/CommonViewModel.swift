//
//  CommonViewModel.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel : NSObject {
    //Navigation 타이틀 추가하고 드라이버형식으로 선언하자
    let title: Driver<String>//Navigation Item에 쉽게바인딩하게끔..
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorRecover: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
    
}
