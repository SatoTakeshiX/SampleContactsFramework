//
//  ViewController.swift
//  SampleContactsFramework
//
//  Created by satoutakeshi on 2015/11/04.
//  Copyright © 2015年 satoutakeshi. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var selectValue: UILabel!
    @IBOutlet weak var selectKey: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //CNContactPickerを作成
        let picker = CNContactPickerViewController()

        //デリゲート設定
        picker.delegate = self
        
        // メールアドレスのみ表示する
        let displayedItems = [CNContactEmailAddressesKey]
        picker.displayedPropertyKeys = displayedItems
        
        // Show the picker
        self.presentViewController(picker, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        
        let contact = contactProperty.contact
        //ユーザーの名前を取得する
        let contactName = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? ""
        
        //CNContactPickerで選択したプロパティを取得
        let propertyName = CNContact.localizedStringForKey(contactProperty.key)

        //ユーザー名を表示
        userName.text = contactName
        
        //取得したキー名を表示
        selectKey.text = propertyName
        
        //取得した値を表示
        selectValue.text = contactProperty.value?.description
        
    }
    
}

