//
//  YemeklerTableView.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import UIKit
import Kingfisher

class YemeklerTableView: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var yemekAciklamasi: UILabel?
    @IBOutlet weak var yemekAdi: UILabel?
    @IBOutlet weak var yemekFiyat: UILabel?
    @IBOutlet weak var yemekResim: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
