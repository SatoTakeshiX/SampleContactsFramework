//
//  AddressBookViewController.swift
//  SampleContactsFramework
//
//  Created by satoutakeshi on 2015/11/04.
//  Copyright © 2015年 satoutakeshi. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class AddressBookViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMailAdress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let peoplePicker = ABPeoplePickerNavigationController()
        peoplePicker.peoplePickerDelegate = self;
        self.presentViewController(peoplePicker, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ユーザーが操作をキャンセルしたときに呼ばれる
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController) {
        //ピッカーを非表示にする
       self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord) -> Bool {
        
        //人物情報の表示
        self.displayPerson(person)
        //ピッカーを非表示にする
        self.dismissViewControllerAnimated(true, completion: nil)
        
        return false
    }

    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        return false
    }
    
    
    
    func displayPerson(person: ABRecordRef){
        let first = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
        let last  = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String
        
        let adress = ABRecordCopyValue(person, kABPersonEmailProperty)?.takeRetainedValue() as? String
        
        
        let emailProperty: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef
        let allEmailIDs: NSArray = ABMultiValueCopyArrayOfAllValues(emailProperty).takeUnretainedValue() as NSArray
        for email in allEmailIDs {
            let emailID = email as! String
            print ("contactEmail : \(emailID) :=>")
            userMailAdress.text = emailID
        }
        
        userName.text = "\(first!) \(last!)"
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        //人物情報の表示
        self.displayPerson(person)

        //ピッカーを非表示にする
       // self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

}
