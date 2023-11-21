//
//  SepetTableView.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 7.11.2023.
//

import UIKit

class SepetTableView: UITableViewCell {

    @IBOutlet weak var yemekAdet: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekAdi: UILabel!
    @IBOutlet weak var yemekResim: UIImageView!
    
    var sepetViewModel = SepetSayfaViewModel()
    var sepettekiYemekler:SepetYemekler?
    var sepetYemeklerListesi = [SepetYemekler]()
    var yemeklerListesi = [Yemekler]()
    var yemekler:Yemekler?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func eksiButtonTiklandi(_ sender: UIButton) {
                
    }
    
    @IBAction func artiButtonTiklandi(_ sender: UIButton) {
  
    }
    
}
    
