//
//  Scene.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import UIKit

//App 에서 구현할 신을 열거형으로..
enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {//스토리 보드에있는 씬을 생성하고 연관값에 저장된 뷰모델을 리턴하는 메소드 구현하기
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            listVC.bind(viewModel: viewModel)
            return nav
        case .detail(let viewModel) :
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else{
                fatalError()
            }
            
            detailVC.bind(viewModel: viewModel)
            return detailVC
        case .compose(let viewModel) :
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else{
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return composeVC
        }
    }
}
