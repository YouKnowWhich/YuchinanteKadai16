//
//  ViewController.swift
//  
//  
//  Created by Yuchinante on 2024/04/29
//  
//

import UIKit

class TableViewController: UITableViewController {

    // UserDefaultsに保存するキー名
    private let keyName = "Name"
    private let keyCheck = "Check"

    // アクセサリボタンがタップされたセルのインデックスパスを保持するプロパティ
    private var editIndexPath: IndexPath?

    // テーブルビューに表示するアイテムの配列
    private var items: [[String: Any]] = []

    // 画面がロードされた時の処理
    override func viewDidLoad() {
        super.viewDidLoad()

        // アイテムの初期化
        items = [
            [keyName: "りんご", keyCheck: false],
            [keyName: "みかん", keyCheck: true],
            [keyName: "バナナ", keyCheck: false],
            [keyName: "パイナップル", keyCheck: true]
        ]
    }

    // セルの数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // セルを構築するメソッド
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得し、カスタムセルにダウンキャスト
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! ItemTableViewCell
        // アイテムを取得
        let item = items[indexPath.row]
        // セルの表示を設定するメソッドを呼び出してセルを更新
        cell.configure(name: (item[keyName] as? String) ?? "", isChecked: (item[keyCheck] as? Bool) ?? false)
        // 更新されたセルを返す
        return cell
    }

    // ユーザーがテーブルビューのセルを選択した時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // チェック状態を反転させる
        if let check = items[indexPath.row][keyCheck] as? Bool {
            items[indexPath.row][keyCheck] = !check
            // テーブルビューのセルを再読み込みして更新する
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // アクセサリボタンがタップされた時の処理
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("accessoryButtonTappedForRowWith")
        // 編集対象のセルのインデックスパスを保持する
        editIndexPath = indexPath
        // 編集画面に遷移する
        performSegue(withIdentifier: "EditSegue", sender: indexPath)
    }

    // セグエが実行される直前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let add = (segue.destination as? UINavigationController)?.topViewController as? AddItemViewController {
            switch segue.identifier ?? "" {
            case "AddSegue":
                // 追加モードを設定する
                add.mode = .add
            case "EditSegue":
                // 編集モードを設定する
                if let indexPath = sender as? IndexPath {
                    let item = self.items[indexPath.row]
                    // 編集対象のアイテム名を渡す
                    add.mode = .edit((item[keyName] as? String) ?? "")
                }
            default:
                break
            }
        }
    }

    // 追加モードを押された時のボタン
    @IBAction func exitFromAddByCancel(segue: UIStoryboardSegue) {
    }
    @IBAction func exitFromAddBySave(segue: UIStoryboardSegue) {
        if let add = segue.source as? AddItemViewController {

            // アイテム名とチェック状態を辞書型に格納し、itemsに追加する
            let item: [String: Any] = [keyName: add.name, keyCheck: false]
            items.append(item)
            let indexPath = IndexPath(row: items.count - 1, section: 0)
            // テーブルビューに行を追加する
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }

    // 編集モードを押された時のボタン
    @IBAction func exitFromEditByCancel(segue: UIStoryboardSegue) {
    }

    @IBAction func exitFromEditBySave(segue: UIStoryboardSegue) {
        if let add = segue.source as? AddItemViewController {
            if let indexPath = editIndexPath {
                // アイテム名を更新する
                items[indexPath.row][keyName] = add.name
                // テーブルビューの行を再読み込みする
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
