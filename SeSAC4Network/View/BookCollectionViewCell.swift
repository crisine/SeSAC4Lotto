//
//  BookCollectionViewCell.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(data: Document) {
        titleLabel.text = data.title
        titleLabel.textColor = .white
        
        dateLabel.text = Util.changeISODateStringFormat(isoDateString: data.datetime, formatTo: "MM-dd")
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        
        let url = URL(string: data.thumbnail)
        bookImageView.kf.setImage(with: url)
        bookImageView.contentMode = .scaleAspectFill
        
        self.backgroundColor = UIColor(red: Double.random(in: 0...0.5), green: Double.random(in: 0...0.5), blue: Double.random(in: 0...0.5), alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
}
