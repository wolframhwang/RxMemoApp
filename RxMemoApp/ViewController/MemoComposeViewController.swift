//
//  MemoComposeViewController.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController,ViewModelBindableType {
    var viewModel: MemoComposeViewModel!

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FUCKKKK")
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        //네비게이션 타이틀바인딩하기
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)
        
        cancelButton.rx.action = viewModel.cancelAction//action 은 action에 바인딩하면됌!
        
        //Tap 하고! double탭 막을려고 쓰로틀링해야해
        saveButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx.disposeBag)
        
        let willShowObervable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0}
        
        let willHideObservable =
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { noti -> CGFloat in 0}
        let keyboardObservable = Observable.merge(willShowObervable, willHideObservable)
            .share()
        
        keyboardObservable.subscribe(onNext: { [weak self] height in
            guard let strongSelf = self else { return }
            var inset = strongSelf.contentTextView.contentInset
            inset.bottom = height
            
            var scrollInset = strongSelf.contentTextView.scrollIndicatorInsets
            scrollInset.bottom = height
            UIView.animate(withDuration: 0.3) {
                strongSelf.contentTextView.contentInset = inset
                strongSelf.contentTextView.scrollIndicatorInsets = scrollInset
            }
        }).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
