//
//  ViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/16/24.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

