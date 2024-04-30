//
//  ItemTableViewCell.swift
//  YuchinanteKadai16
//  
//  Created by Yuchinante on 2024/04/29
//  
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    // アイテム名が選択されているかを表示する画像ビュー
    @IBOutlet weak var checkImageView: UIImageView!
    
    // アイテム名を表示するラベル
    @IBOutlet weak var nameLabel: UILabel!

    // セルの表示を設定するメソッド
    func configure(name: String, isChecked: Bool) {
        if isChecked {
            checkImageView.image = UIImage(named: "check")  // チェックマークの画像を表示
        } else {
            checkImageView.image = nil  // チェックマークの画像を非表示
        }

        // ラベルにアイテム名を表示
        nameLabel.text = name
    }
}
