//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Emre Alpago on 17.02.2022.
//

import UIKit

protocol TableViewCellDelegate {
    func didselectItem(model:Article)
}

class NewsTableViewCell: UITableViewCell {
    
    var newsModel: Article?
    
    @IBOutlet var newsLabel: UILabel!
    @IBOutlet var newsSubtitle: UILabel!
    @IBOutlet var newsImage: UIImageView! 
    @IBOutlet var cellButton: UIButton!
    var delegate:TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initiliaze(cellModel: Article) {
        newsModel = cellModel
        self.prepareUI()
        
    }
    
    func prepareUI(){
        if let newsModel = self.newsModel {
            newsLabel.text = newsModel.title
            newsSubtitle.text = newsModel.description
            newsImage.downloaded(from: newsModel.urlToImage ?? "")
        }
    }
    
    @IBAction func cellButtonTapped(){
        delegate?.didselectItem(model: newsModel!)
    }
}

