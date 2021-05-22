//
//  MemoDetailViewController.swift
//  RxMemoApp
//
//  Created by 황지웅 on 2021/05/16.
//

import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewController: UIViewController, ViewModelBindableType {
    
    var viewModel : MemoDetailViewModel!
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var deletButton: UIBarButtonItem!
    @IBOutlet weak var editbutton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents//table binding
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0 :
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }.disposed(by: rx.disposeBag)
        
        //Table View와 Content를 반영하고있음..?
        editbutton.rx.action = viewModel.makeEditAction()
        deletButton.rx.action = viewModel.makeDeleteAction()
        
        
        shareButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext : {[weak self] _ in
                guard let memo = self?.viewModel.memo.content else {return}
                let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                self?.present(vc, animated: true, completion: nil)
            }).disposed(by: self.rx.disposeBag)
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
