//
//  MemoComposeViewModel.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel : CommonViewModel{//Compose Scene에서 사용함!
    //메모 추가, 펹빕할떙
    // 메모 속성
    private let content : String? // 새로운 메모는 닐 , 편집할때는 편집할 메모
    
    //View에 바인딩할수있도록  드라이버까지
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    
    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil) {
        self.content = content
        
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map {
                _ in
                
            }
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map {_ in}
        }
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
