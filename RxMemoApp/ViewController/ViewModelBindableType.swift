//
//  ViewModelBindableType.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import UIKit

protocol ViewModelBindableType {
    //@discardableResult
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set}
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    //뷰컨트롤러에 추가된 뷰모델 속성의 실제 뷰모델을 저장하고 바인드 뷰 모델 메소드를 자동으로 호출하는 메소드를 작성한당
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}


