//
//  ArticleCeell.swift
//  ReaderAppSample
//
//  Created by 大川葵 on 2019/06/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    // MARK: UITableViewCell
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byCharWrapping
        dateLabel.textColor = UIColor.gray
        tagsLabel.textColor = UIColor.gray
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.white
        self.selectedBackgroundView = cellSelectedBgView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
