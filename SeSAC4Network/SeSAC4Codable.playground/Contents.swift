import UIKit

let jsonData = """
{
  "author": "Hue",
  "quote": "어디까지 디버깅 하셨나요?",
  "like": 2345
}
"""

// 1. 키가 다르면 오류 발생 => Optional을 붙여서 해결하면? -> nil로 다 들어와서 원하는 값을 얻을 수 없음.
// 2. CodingKeys를 통해 키값을 매칭

struct Quote: Codable {
    let quote_content: String
    let author_name: String
    let likeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case quote_content = "quote"
        case author_name = "author"
        case likeCount = "like"
    }
}

// String Data 타입으로 변환 -> Data 타입을 Quote 구조체 타입 변환

func myDecoding() {
    
    guard let data = jsonData.data(using: .utf8) else {
        print("An error occured while \(#function)")
        return
    }
    
    do {
        let value = try JSONDecoder().decode(Quote.self, from: data)
        
        print(value)
    } catch {
        print(error)
    }
}

myDecoding()
