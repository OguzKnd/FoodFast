//
//  DetaySayfaViewModel.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import UIKit

class DetaySayfaViewModel {
    
    var yrepo = YemeklerDaoRepository()
    
    func sepeteKaydet(yemek_adi:String,yemek_fiyat:String,yemek_resim_adi:String, yemek_siparis_adet:String,kullanici_adi:String){
        yrepo.sepeteYemekEkle(yemek_adi: yemek_adi, yemek_fiyat: yemek_fiyat, yemek_resim_adi: yemek_resim_adi, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
        
    }
}

