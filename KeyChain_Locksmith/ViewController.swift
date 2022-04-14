//
//  ViewController.swift
//  KeyChain_Locksmith
//
//  Created by kimjitae on 2022/04/13.
//

import UIKit
import Locksmith


class ViewController: UIViewController {

    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var pw = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let pwDic = Locksmith.loadDataForUserAccount(userAccount: Bundle.bundleIdentifier) {
            if let pw = pwDic["user_pwdKey"] {
                self.pw = "\(pw)"
                pwLabel.text = "\(pw)"
            } else {
                pwLabel.text = "pw가 존재하지 않습니다."
            }
        } else {
            pwLabel.text = "pwDic가 존재하지 않습니다."
        }
    }
    @IBAction func pwSave(_ sender: Any) {
        print("비밀번호를 저장합니다.")
        guard let pw = pwTextField.text else { return }
        try? Locksmith.saveData(data: ["user_pwdKey": pw], forUserAccount: Bundle.bundleIdentifier, inService: Bundle.bundleIdentifier)
    }
    @IBAction func pwSelect(_ sender: Any) {
        print("비밀번호를 변경합니다.")
        if let pwDic = Locksmith.loadDataForUserAccount(userAccount: Bundle.bundleIdentifier) {
            if let pw = pwDic["user_pwdKey"] {
                self.pw = "\(pw)"
                pwLabel.text = "\(pw)"
            } else {
                pwLabel.text = "pw가 존재하지 않습니다."
            }
        } else {
            pwLabel.text = "pwDic가 존재하지 않습니다."
        }
    }
    @IBAction func pwUpdate(_ sender: Any) {
        print("비밀번호를 업데이트합니다.")
        guard let pw = pwTextField.text else { return }
        try? Locksmith.updateData(data: ["user_pwdKey": pw], forUserAccount: Bundle.bundleIdentifier, inService: Bundle.bundleIdentifier)
    }
    @IBAction func pwDelete(_ sender: Any) {
        print("비밀번호를 삭제합니다.")
        try? Locksmith.deleteDataForUserAccount(userAccount: Bundle.bundleIdentifier, inService: Bundle.bundleIdentifier)
    }
    
    @IBAction func infoSave(_ sender: Any) {
        guard let name = nameTextField.text, let age = ageTextField.text, let adress = adressTextField.text else { return }
        try? Locksmith.saveData(data: ["user_name": name, "user_age": age, "user_adress": adress], forUserAccount: self.pw, inService: Bundle.bundleIdentifier)
    }
    
    @IBAction func infoSelect(_ sender: Any) {
        if let infoDetail = Locksmith.loadDataForUserAccount(userAccount: self.pw) {
            resultLabel.text = "pw가 \(pw)인 사람의 이름은 \(infoDetail["user_name"]!)이고 나이는 \(infoDetail["user_age"]!), 사는 곳은 \(infoDetail["user_adress"]!)이다"
        } else {
            resultLabel.text = "Dic가 존재하지 않습니다."
        }
    }
    
    @IBAction func infoUpdate(_ sender: Any) {
        guard let name = nameTextField.text, let age = ageTextField.text, let adress = adressTextField.text else { return }
        try? Locksmith.updateData(data: ["user_name": name, "user_age": age, "user_adress": adress], forUserAccount: self.pw, inService: Bundle.bundleIdentifier)
    }
    
    @IBAction func infoDelete(_ sender: Any) {
        try? Locksmith.deleteDataForUserAccount(userAccount: self.pw, inService: Bundle.bundleIdentifier)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}




extension Bundle { /// 앱 이름
    class var appName: String {
        if let value = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return value
        }
        return ""
    } /// 앱 버전
    class var appVersion: String {
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return value
        }
        return ""
    } /// 앱 빌드 버전
    class var appBuildVersion: String {
        if let value = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return value
        }
        return ""
    } /// 앱 번들 ID
    class var bundleIdentifier: String {
        if let value = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String {
            return value
        }
        return ""
    }
}
