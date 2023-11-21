//
//  SepetSayfa.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import Foundation
import UIKit
import Kingfisher

class SepetSayfa:UIViewController {
    
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    @IBOutlet weak var sepetTableView: UITableView!
    
    var yemeklerListesi = [SepetYemekler]()
    var cell = SepetTableView()
    
    var sepetViewModel = SepetSayfaViewModel()
    
    override func viewDidLoad() {
        
        sepetViewModel.sepettekiYemekleriGetir(kullanici_adi: "oguz_kanda")
        
        fiyatLabel.text = "0 ₺"
        sepetTableView.dataSource = self
        sepetTableView.delegate = self
        
        _ = sepetViewModel.sepettekiYemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async {
                self.sepetTableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetViewModel.sepettekiYemekleriGetir(kullanici_adi: "oguz_kanda")
    }
    
    @IBAction func siparişiTamamlaButtonTiklandi(_ sender: UIButton) {
        
    }
    
}

extension SepetSayfa : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let yemek = yemeklerListesi[indexPath.row]
        let hucre = sepetTableView.dequeueReusableCell(withIdentifier: "sepetCell") as! SepetTableView
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            
            if let yemekAdi = hucre.yemekAdi, let yemekResim = hucre.yemekResim {
                
                yemekResim.kf.setImage(with: url)
                yemekAdi.text = yemek.yemek_adi
                hucre.yemekAdet!.text = "\(yemek.yemek_siparis_adet!) Adet"
                hucre.yemekFiyatLabel?.text = "\(yemek.yemek_fiyat!) ₺"
                hesaplaToplamFiyat()
                
            }
        }
        
        return hucre
    }
    
    func hesaplaToplamFiyat() {
        var toplamFiyat = 0
        for yemek in yemeklerListesi {
            if let fiyat = yemek.yemek_fiyat {
                toplamFiyat += Int(fiyat)!
            }
        }
        
        fiyatLabel.text = "\(toplamFiyat)₺"
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){contentUnavailableConfiguration,view,bool in
            let yemek = self.yemeklerListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Sepettek Kaldırma İşlemi", message: "\(yemek.yemek_adi!) Sepetten Kaldırılsın mı? ", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.sepetViewModel.sil(kullanici_adi: yemek.kullanici_adi, sepet_yemek_id: (yemek.sepet_yemek_id!))
                
                
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])

    }
    
    
}
