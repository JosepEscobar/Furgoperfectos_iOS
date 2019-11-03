//
//  ListTableViewCell.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import Kingfisher
import warqLog

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var furgoperfectoImageView: UIImageView!
    @IBOutlet weak var furgoperfectoTitleLabel: UILabel!
    @IBOutlet weak var furgoperfectoDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, description: String, imageURL: String) {
        furgoperfectoTitleLabel?.text = title
        furgoperfectoDescriptionLabel.text = description
        if let url = URL(string: imageURL) {
            let processor = DownsamplingImageProcessor(size: furgoperfectoImageView.bounds.size)
            >> RoundCornerImageProcessor(cornerRadius: 10)
            furgoperfectoImageView.kf.indicatorType = .activity
            furgoperfectoImageView.kf.setImage(
                with: url,
                placeholder: #imageLiteral(resourceName: "furgo_transparent_144"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                    .diskCacheExpiration(StorageExpiration.days(365))
                ])
            {
                result in
                switch result {
                case .success(let value):
                    WarqLog.debug("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    WarqLog.error("Job failed: \(error.localizedDescription)")
                }
            }
        }
        
    }

}
