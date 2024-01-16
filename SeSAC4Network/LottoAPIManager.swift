//
//  LottoAPIManager.swift
//  SeSAC4Network
//
//  Created by Minho on 1/16/24.
//

import Alamofire

struct LottoAPIManager {
    
    static let shared = LottoAPIManager()
    
    private init() { }
    
    func callRequest(number: String, completionHandler: @escaping (Lotto) -> Void) {
        let url = "https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF
            .request(url, method: .get)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    
//                    self.dateLabel.text = success.drwNoDate
                    completionHandler(success) // 탈출 클로저
                    
                case .failure(let failure):
                    print("네트워크 통신 오류 발생: \(failure)")
                }
            }
    }
}
