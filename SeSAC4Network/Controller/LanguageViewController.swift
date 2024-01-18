//
//  LanguageViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import UIKit

class LanguageViewController: UIViewController {
    
    var passedLanguage: LangType?
    var languages = Languages.data
    var dataDelegate : SendDataDelegate?
    var buttonFrom: String?

    @IBOutlet weak var langTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langTableView.delegate = self
        langTableView.dataSource = self
    }

    func passLanguage(selectedLang: LangType) {
        print("언어 넘겨받음")
        buttonFrom = languages[selectedLang.key]
        passedLanguage = selectedLang
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
        return Languages.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "langTableViewCell", for: indexPath)
        
        let currentRowLanguage = languages[LangType(rawValue: indexPath.row)!.key]
        
        // MARK: 이게 맞나...?
        cell.textLabel?.text = currentRowLanguage
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        
        if Languages.data[passedLanguage!.key] == currentRowLanguage {
            cell.textLabel?.textColor = .green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedLanguage = LangType(rawValue: indexPath.row) {
            print("언어 돌려주는중")
            dataDelegate?.recieveData(response: selectedLanguage)
            self.navigationController?.popViewController(animated: true)
        } else {
            print("선택된 언어를 이전 화면으로 넘겨주는데 실패")
        }
    }
}
