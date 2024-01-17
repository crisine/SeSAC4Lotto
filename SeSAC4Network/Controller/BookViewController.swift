//
//  BookViewController.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import UIKit
import Alamofire

// MARK: - Book
struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: Status
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

enum Status: String, Codable {
    case empty = ""
    case 예약판매 = "예약판매"
    case 정상판매 = "정상판매"
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}



class BookViewController: UIViewController {
    
    
    @IBOutlet weak var bookSearchBar: UISearchBar!
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var books: [Document] = [] {
        didSet {
            bookCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let xib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(xib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.setupLayout()
        
        bookCollectionView.collectionViewLayout = layout
        
        self.navigationItem.title = "고래밥님의 책장"
    }

    func callRequest(text: String) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        
        let headers: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        
        AF.request(url, method: .post, headers: headers)
            .responseDecodable(of: Book.self) { response in
                
                switch response.result {
                case .success(let success):
                    dump(success.documents)
                    
                    self.books = success.documents
                    
                case .failure(let failure):
                    dump(failure)
                }
            }
    }
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색바 return 감지")
        if let text = searchBar.text {
            callRequest(text: text)
        }
    }
}


extension BookViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        cell.configureCell(data: books[indexPath.row])
        
        return cell
    }
}


