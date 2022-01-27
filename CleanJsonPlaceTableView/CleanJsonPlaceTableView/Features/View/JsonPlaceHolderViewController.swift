//
//  JsonPlaceHolderViewController.swift
//  CleanJsonPlaceTableView
//
//  Created by Yasemin TOK on 10.10.2021.
//

import UIKit

class JsonPlaceHolderViewController: UIViewController {

    @IBOutlet weak var tableViewJsonPlaceHolder: UITableView!
    
    private let jsonTableView: JsonTableView = JsonTableView()
    private let jsonService: JsonPlaceHolderProtocol = JsonPlaceHolderService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        initService()
    }
    
    func initDelegate() {
        tableViewJsonPlaceHolder.delegate = jsonTableView
        tableViewJsonPlaceHolder.dataSource = jsonTableView
        jsonTableView.delegate = self
    }
    
    func initService() {
        jsonService.fetchAllPosts { [weak self] models in
            self?.jsonTableView.update(items: models)
            self?.tableViewJsonPlaceHolder.reloadData()
        } onFail: { data in
            print(data ?? "")
        }
    }
}

extension JsonPlaceHolderViewController: JsonTableViewOutPut {
    func onSelected(item: PostModel) {
        print(item.title ?? "")
    }
}
