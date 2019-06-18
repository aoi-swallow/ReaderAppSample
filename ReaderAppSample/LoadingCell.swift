//
//  LoadingCell.swift
//  CodingChallenge_iOS_Wantedly
//
//  Created by 大川葵 on 2019/06/09.
//  Copyright © 2019 Nexceed. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    
    // MARK: UITableViewCell
    
    @IBOutlet weak var indicatoreView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startAnimation() {
        
        indicatoreView.startAnimating()
    }
    
}
