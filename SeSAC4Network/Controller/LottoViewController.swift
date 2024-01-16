//
//  LottoViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/16/24.
//

import UIKit

struct Lotto: Codable {
    let drwNo: Int          // 회차
    let drwNoDate: String   // 날짜
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var drwtNoLabels: [UILabel] = []
    
    
    let lottoDrwNoList: [Int] = Array(1...1102).reversed()
    
    let manager = LottoAPIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 회차를 고르면 통신 시작해야 하므로 Block
//        manager.callRequest(number: "1102") { value in
//            self.dateLabel.text = value
//        }
        
        createPickerView()
        
        numberTextField.placeholder = "회차를 선택하세요"
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
            let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(didTappedOnToolbar))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            toolBar.setItems([space , btnDone], animated: true)
            toolBar.isUserInteractionEnabled = true
        
        numberTextField.inputView = pickerView
        numberTextField.inputAccessoryView = toolBar
    }
    
    func configureDateLabel(date: String) {
        dateLabel.text = date
    }
    
    func configureLottoBalls(lottoInfo: Lotto) {
        
        let lottoNumbers = [lottoInfo.drwtNo1, lottoInfo.drwtNo2, lottoInfo.drwtNo3,
                            lottoInfo.drwtNo4, lottoInfo.drwtNo5, lottoInfo.drwtNo6, lottoInfo.bnusNo]
        
        for index in drwtNoLabels.indices {
            configureLottoBallLabel(label: drwtNoLabels[index], number: lottoNumbers[index])
        }
    }
    
    func configureLottoBallLabel(label: UILabel, number: Int) {
        label.backgroundColor = setupLottoBallColor(number: number)
        label.text = String(number)
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = label.frame.width / 2
    }
    
    func setupLottoBallColor(number: Int) -> UIColor {
        switch number {
        case 1...10:
            return .yellow
        case 11...20:
            return .blue
        case 21...30:
            return .red
        case 31...40:
            return .gray
        case 41...45:
            return .green
        default:
            return .clear
        }
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        requestLottoInfo()
        
        numberTextField.resignFirstResponder()
    }
    
    @objc func didTappedOnToolbar() {
        requestLottoInfo()
        
        numberTextField.resignFirstResponder()
    }
}

extension LottoViewController {
    func requestLottoInfo()  {
        if let number = numberTextField.text {
            manager.callRequest(number: number) { value in
                self.configureLottoBalls(lottoInfo: value)
                self.configureDateLabel(date: value.drwNoDate)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate,
                               UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoDrwNoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(lottoDrwNoList[row]) 회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = String(lottoDrwNoList[row])
    }
}
