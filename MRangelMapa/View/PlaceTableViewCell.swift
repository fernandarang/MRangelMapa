//
//  PlaceTableViewCell.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLugar: UILabel!
    @IBOutlet weak var direccionLugar: UILabel!
    @IBOutlet weak var ciudadLugar: UILabel!
    @IBOutlet weak var raitingLugar: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
