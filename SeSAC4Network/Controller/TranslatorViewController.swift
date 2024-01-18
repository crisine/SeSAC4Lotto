//
//  ViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/16/24.
//

import UIKit
import Alamofire

/*
 {
     "message": {
         "@type": "response",
         "@service": "naverservice.nmt.proxy",
         "@version": "1.0.0",
         "result": {
             "srcLangType": "ko",
             "tarLangType": "en",
             "translatedText": "Hello, my name is Miseong.",
             "engineType": "N2MT"
         }
     }
 }
 */

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoFinal
}

struct PapagoFinal: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

class TranslatorViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var srcLangButton: UIButton!
    @IBOutlet weak var descLangButton: UIButton!
    @IBOutlet weak var replaceEachOtherLangButton: UIButton!
    
    var selectedButton: PapagoLangButtonType = .source
    
    var srcLang = LangType.korean {
        didSet {
            if let titleText = Languages.data[srcLang.key] {
                srcLangButton.setTitle(titleText, for: .normal)
            }
        }
    }
    var descLang = LangType.english {
        didSet {
            if let titleText = Languages.data[descLang.key] {
                descLangButton.setTitle(titleText, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateButton.addTarget(self, action: #selector(didtranslateButtonTapped), for: .touchUpInside)
        
        configureNavigation()
        configureButtons()
        
        targetLabel.numberOfLines = 0
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    func configureButtons() {
        srcLangButton.setTitle(Languages.data[srcLang.key], for: .normal)
        srcLangButton.configureStyle()
    
        descLangButton.setTitle(Languages.data[descLang.key], for: .normal)
        descLangButton.configureStyle()
        
        replaceEachOtherLangButton.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        replaceEachOtherLangButton.tintColor = .black
    }

    /*
        실제로 앱을 출시했다고 했을 때 고려해야 할 점
     
     1. 네트워크 통신이 단절되었을 때 어떻게 할 것인지?
     2. API 콜의 상한치를 도달한 경우 어떻게 할 것인지?
     3. 번역 버튼의 클릭 횟수 (1초에 수십번 누르는 경우 등) 를 어떻게 제한할 것인지
     4. 최소한의 텍스트 수를 제한하기 (예. '안' 과 같이 한 글자만 보내는 경우 등을 방지)
     5. 컨텐츠를 불러오는 동안 Progress Bar 나 LoadingView 를 띄우기
     
     */
    @objc func didtranslateButtonTapped() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.clientID,
                                    "X-Naver-Client-Secret": APIKey.clientSecret]
        
        let parameters: Parameters = ["text": sourceTextView.text!,
                                      "source": srcLang.key,
                                      "target": descLang.key]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: Papago.self) { response in
                
                switch response.result {
                case .success(let success):
                    dump(success)
                    
                    self.targetLabel.text = success.message.result.translatedText
                    
                case .failure(let failure):
                    dump(failure)
                }
            }
    }
    
    
    @IBAction func didSrcLangButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: LanguageViewController.identifier) as! LanguageViewController
        
        let selectedLanguage = srcLang
        selectedButton = .source
        
        vc.dataDelegate = self
        vc.passLanguage(selectedLang: srcLang)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didDescLangButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: LanguageViewController.identifier) as! LanguageViewController

        let selectedLanguage = descLang
        selectedButton = .destination
        
        vc.dataDelegate = self
        vc.passLanguage(selectedLang: descLang)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func didreplaceEachOtherLangButtonTapped(_ sender: UIButton) {
        let tempLanguage = srcLang
        srcLang = descLang
        descLang = tempLanguage
    }
}

extension TranslatorViewController: SendDataDelegate {
    func recieveData(response: LangType) {
        
        print("선택한 언어 LanguageViewController 로부터 돌려받음")
        
        let buttonFrom = selectedButton
        let selectedLang = Languages.data[response.key]
        
        switch buttonFrom {
        case .source:
            srcLangButton.setTitle(selectedLang, for: .normal)
            srcLang = response
        case .destination:
            descLangButton.setTitle(selectedLang, for: .normal)
            descLang = response
        }
    }
}

