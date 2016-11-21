//
//  ViewController.swift
//  RealmDemo
//
//  Created by David on 2016/11/21.
//
//

import UIKit
import RealmSwift

class Person : Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var birthday: Date = Date()
    dynamic var email: String?
    var phones: List<PhoneNumber> = List<PhoneNumber>()
}

class PhoneNumber : Object {
    dynamic var number: String = ""
    dynamic var carrier: String = ""
    dynamic var notes: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let john = Person()
//        john.firstName = "John"
//        john.lastName = "Sena"
        
//        let realm = try! Realm()
//        realm.beginWrite()
//        realm.add(john)
//        try! realm.commitWrite()
        
        let realm = try! Realm()
        let peoplo: [Person] = realm.objects(Person.self).map { $0 }
        print(peoplo)
        
        let john = realm.objects(Person.self).filter("lastName = %@", "Sena").map { $0 }.first
        
        let phone1 = PhoneNumber()
        phone1.number = "0912345678"
        phone1.carrier = "中華電信"

        let phone2 = PhoneNumber()
        phone2.number = "+1-626-428-6293"
        phone2.carrier = "AT&T"
        phone2.notes = "美國AT&T預付卡"
        
        realm.beginWrite()
        // 因為你要對一個已經從資料庫抓出來的資料做編輯，一定要告訴realm我要開始寫入了
        // 不加會炸掉
        // 詳情請看 https://realm.io
        john?.phones.append(contentsOf: [phone1, phone2])
        try! realm.commitWrite()
        // 做完這件事john就會有很多電話了
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    
    
    

}
