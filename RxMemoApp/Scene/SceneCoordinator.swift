//
//  SceneCoordinator.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController : UIViewController {
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag()//리소스 정리용!
    
    //화면 전환 담당하므로 윈도우랑 현재 화면에 관한정보를가져야해
    private var window: UIWindow
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            print(currentVC)
            guard let nav = currentVC.navigationController else {//Navigation Controller에 접근할수 없다는얘기임..
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.rx.willShow
                .subscribe(onNext: {[unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            
            subject.onCompleted()
        case .modal :
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            }else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            }else {
                completable(.error(TransitionError.unknown))
            }
            return Disposables.create()
        }
    }
    
    
}
