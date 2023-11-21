//
//  AnasayfaViewModel.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var yrepo = YemeklerDaoRepository()
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    init(){
        yemeklerListesi = yrepo.yemeklerListesi
        yemekleriYukle()
    }
    
    func ara(aramaKelimesi:String){
        yrepo.ara(aramaKelimesi: aramaKelimesi)
        
    }
    
    func yemekleriYukle(){
        yrepo.yemekleriYukle()
    }
    
    
    
}


