//
//  DetaySayfa.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import Foundation
import UIKit
import Kingfisher

class DetaySayfa:UIViewController {
    
    @IBOutlet weak var adet: UILabel!
    @IBOutlet weak var yemekAdi: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekResim: UIImageView!
    
    var yemek:Yemekler?
    var viewModel = DetaySayfaViewModel()
    var sepetYemek:SepetYemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adet.text = "1"
        
        if let yemek = yemek {
            yemekAdi.text = yemek.yemek_adi
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
                if let yemekAdi = yemekAdi, let yemekResim = yemekResim {
                    yemekResim.kf.setImage(with: url)
                    yemekAdi.text = yemek.yemek_adi
                    yemekFiyatLabel?.text = "\(yemek.yemek_fiyat!)"
                    
                }
            }
        }
    }
    
    @IBAction func eksiButton(_ sender: Any) {
        
        if let siparisSayisi = Int(adet.text ?? "") {
            if siparisSayisi > 0 {
                adet.text = "\(siparisSayisi - 1)"
                updateSiparisTutari()
            }
        }
    }
    
    @IBAction func artiButton(_ sender: Any) {
        if let siparisSayisi = Int(adet.text ?? "") {
            adet.text = "\(siparisSayisi + 1)"
            updateSiparisTutari()
        }
    }
    
    func updateSiparisTutari() {
        if let siparisSayisiString = adet.text, 
            let siparisSayisi = Int(siparisSayisiString),
            let yemekFiyat = Int(yemek?.yemek_fiyat ?? "") {
            let siparisTutari = siparisSayisi * yemekFiyat
            yemekFiyatLabel.text = "\(siparisTutari)"
        }
    }
    
    @IBAction func sepeteEkleButton(_ sender: UIButton) {
        if  let yemek_adi = yemekAdi.text,
            let yemek_fiyat = yemekFiyatLabel.text,
            let yemek_siparis_adet = (adet.text){
            
            
            viewModel.sepeteKaydet(yemek_adi: yemek_adi,
                                   yemek_fiyat: yemek_fiyat,
                                   yemek_resim_adi:(yemek!.yemek_resim_adi!),
                                   yemek_siparis_adet: yemek_siparis_adet,
                                   kullanici_adi: "oguz_kanda")
        }
        
        if let tabBarController = self.tabBarController {
            
            let sepetTabIndex = 1 // SepetSayfa'nın tabbar indeksi (sıfırdan başlayarak)
            
            if let tabItems = tabBarController.tabBar.items {
                let sepetTabItem = tabItems[sepetTabIndex]
                let currentBadgeValue = sepetTabItem.badgeValue ?? "0"
                if let currentCount = Int(currentBadgeValue) {
                sepetTabItem.badgeValue = "\(currentCount + Int(adet.text!)!)"
                    
                }
            }
        }
    }
}
