//
//  MarketViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/16/24.
//

import UIKit
import Alamofire

struct Market: Codable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController,
                            UITableViewDelegate,
                            UITableViewDataSource {
    
    @IBOutlet weak var marketTableView: UITableView!
    
    
    var marketList: [Market] = [] {
        didSet {
            marketTableView.reloadData()
            print("didSet Called")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        
        marketTableView.delegate = self
        marketTableView.dataSource = self
    }
    
    func callRequest() {
        
        let url = "https://api.upbit.com/v1/market/all"
        
        // 200~299 Success
        // 400~499 Client Request Error
        // 500~ Server Error
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Market].self) { response in
        
            switch response.result {
            case .success(let success):
                dump(success)
                
                if response.response?.statusCode == 200 {
                    print("야호 200")
                }
                
                self.marketList = success
            case .failure(let failure):
                print("통신 오류 : \(failure)")
            }
        }
    }
}

extension MarketViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketTableViewCell", for: indexPath)
        
        cell.textLabel?.text = marketList[indexPath.row].market
        cell.detailTextLabel?.text = marketList[indexPath.row].korean_name
        
        return cell
    }
}
