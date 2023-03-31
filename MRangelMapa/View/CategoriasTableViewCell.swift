//
//  CategoriasTableViewCell.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import UIKit

class CategoriasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImagenCategoria: UIImageView!
    @IBOutlet weak var nombreLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
