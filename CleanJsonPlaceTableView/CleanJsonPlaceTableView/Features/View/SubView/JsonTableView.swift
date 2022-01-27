//
//  JsonTableView.swift
//  CleanJsonPlaceTableView
//
//  Created by Yasemin TOK on 10.10.2021.
//

import UIKit

protocol JsonTableViewProtocol {
    func update(items : [PostModel])
}

protocol JsonTableViewOutPut: class {
    func onSelected(item : PostModel)
}

final class JsonTableView : NSObject {
    private lazy var items: [PostModel] = []
    
    weak var delegate: JsonTableViewOutPut?
}

extension JsonTableView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(item: items[indexPath.row])
    }
}

extension JsonTableView: JsonTableViewProtocol {
    func update(items: [PostModel]) {
        self.items = items
    }
}
