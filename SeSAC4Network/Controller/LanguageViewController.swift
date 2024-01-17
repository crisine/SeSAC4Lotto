//
//  LanguageViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import UIKit

class LanguageViewController: UIViewController {
    
    var passedLanguage: LangType?
    var languages = LangType.allCases
    var dataDelegate : SendDataDelegate?
    var buttonFrom: String?

    @IBOutlet weak var langTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langTableView.delegate = self
        langTableView.dataSource = self
    }

    func passLanguage(selectedLang: [String: String]) {
        print("언어 넘겨받음")
        let lang = selectedLang.first!
        buttonFrom = lang.key
        passedLanguage = LangType(rawValue: lang.value)
    }
    
    
}

extension LanguageViewController: UITableViewDelegate,
                                  UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LangType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "langTableViewCell", for: indexPath)
        
        let currentRowLanguage = languages[indexPath.row].value
        
        // MARK: 이게 맞나...?
        cell.textLabel?.text = currentRowLanguage.first?.value
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        
        if passedLanguage?.value == currentRowLanguage {
            cell.textLabel?.textColor = .green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedLanguage = languages[indexPath.row].value.first!.key
        
        print("언어 돌려주는중")
        dataDelegate?.recieveData(response: [buttonFrom!: selectedLanguage])
        self.navigationController?.popViewController(animated: true)
    }
}
