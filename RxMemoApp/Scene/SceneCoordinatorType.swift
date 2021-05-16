//
//  SceneCoordinatorType.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style : TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult//리턴형을 사용하지 않는다는 경고는 발생하지않음!
    func close(animated: Bool) -> Completable//현재 씬 닫고 이전씬으로 돌아가게행 구독자 추가하고 화면작업완려된 뒤에... 돌아가는용도임
}
