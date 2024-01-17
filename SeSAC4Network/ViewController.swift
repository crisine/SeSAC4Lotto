//
//  ViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/16/24.
//

import UIKit
import Alamofire

struct Jack {
    let boxOfficeResult: SmallJack
}

struct SmallJack {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieJack]
}

struct MovieJack {
    let movieNm: String
    let audiAcc: Int
}

class ViewController: UIViewController {

    
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateButton.addTarget(self, action: #selector(didtranslateButtonTapped), for: .touchUpInside)
    }

    @objc func didtranslateButtonTapped() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": "VINXRj4R2REWWkj_IoME",
                       "X-Naver-Client-Secret": "cwFzIOHCMN"]
        
        let parameters: Parameters = ["text": sourceTextView.text!,
                          "source": "ko",
                          "target": "en"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
    }
}

