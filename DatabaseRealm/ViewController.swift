//
//  ViewController.swift
//  DatabaseRealm
//
//  Created by 高橋　龍 on 2021/08/17.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleTextField.delegate = self
        contentTextField.delegate = self
        
        //memoを初期化する
        let memo: Memo? = read()
        
        //取得したメモの内容を反映する
        //Memoクラスにある奴ら
        if let memo = memo {
            titleTextField.text = memo.title
            contentTextField.text = memo.content
        }
    }


    func read() -> Memo? {
        //データベース中のfirstデータを取得する
        return realm.objects(Memo.self).first
    }
    
    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!
        
        let memo: Memo? = read()
        
        //memoの中身がnilかどうかを調べている(Optionl Binding)
        if let memo = memo {
            try! realm.write{
                memo.title = title
                memo.content = content
            }
        //memoがnilだった時
        }else {
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write{
                realm.add(newMemo)
            }
        }
        
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

