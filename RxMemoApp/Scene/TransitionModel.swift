//
//  TransitionModel.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

//화면전환시 문제 발생에ㅓㅅ 쓸 에러!

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}

