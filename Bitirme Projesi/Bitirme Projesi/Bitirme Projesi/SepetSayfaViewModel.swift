//
//  SepetSayfaViewModel.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import Foundation
import RxSwift

class SepetSayfaViewModel {
    var yrepo = YemeklerDaoRepository()
    var sepettekiYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    
    init(){
        
        sepettekiYemeklerListesi = yrepo.sepettekiYemekler
        sepettekiYemekleriGetir(kullanici_adi: "oguz_kanda")
    }
    
    func sepettekiYemekleriGetir(kullanici_adi:String) {
        yrepo.sepettekiYemekleriGetir(kullanici_adi: kullanici_adi)
    }
    
    func sil(kullanici_adi:String,sepet_yemek_id:String){
        yrepo.sil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }

}
