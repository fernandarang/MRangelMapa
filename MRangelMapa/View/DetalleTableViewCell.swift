//
//  DetalleTableViewCell.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 24/03/23.
//

import UIKit

class DetalleTableViewCell: UITableViewCell {

    @IBOutlet weak var datosLbl: UILabel!
    @IBOutlet weak var IconoContacto: UIImageView!
    @IBOutlet weak var ViewIcono: UIView!
    @IBOutlet weak var espacio: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
