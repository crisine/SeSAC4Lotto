//
//  LangType.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import Foundation

enum LangType: String, CaseIterable {
    case korean = "ko"
    case english = "en"
    case japanese = "ja"
    case chinese = "zh-CN"
    case taiwanese = "zh-TW"
    case vietnamese = "vi"
    case indonesian = "id"
    case thai = "th"
    case deutsch = "de"
    case russian = "ru"
    case espanol = "es"
    case italian = "it"
    case french = "fr"
    
    var value: [String: String] {
        switch self {
        case .korean:
            return ["ko": "한국어"]
        case .english:
            return ["en": "영어"]
        case .japanese:
            return ["ja": "일본어"]
        case .chinese:
            return ["zh-CN": "중국어 간체"]
        case .taiwanese:
            return ["zh-TW": "중국어 번체"]
        case .vietnamese:
            return ["vi": "베트남어"]
        case .indonesian:
            return ["id": "인도네시아어"]
        case .thai:
            return ["th": "태국어"]
        case .deutsch:
            return ["de": "독일어"]
        case .russian:
            return ["ru": "러시아어"]
        case .espanol:
            return ["es": "스페인어"]
        case .italian:
            return ["it": "이탈리아어"]
        case .french:
            return ["fr": "프랑스어"]
        }
    }
}
