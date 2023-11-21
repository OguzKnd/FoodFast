//
//  YemeklerDaoRepository.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import Foundation
import RxSwift
import Alamofire

class YemeklerDaoRepository {
    
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var sepettekiYemekler = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    
    func ara(aramaKelimesi:String){
        
        let params:Parameters = ["yemek_adi":aramaKelimesi]
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .post,parameters: params).response {
            response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler{
                        self.yemeklerListesi.onNext(liste)//Tetikleme
                    }
                }catch {
                    print(String(describing: error))
                }
            } else {
            }
        }
    }
    
    func yemekleriYukle(){
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response {
            response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler{
                        self.yemeklerListesi.onNext(liste)//Tetikleme
                        
                    }
                }catch {
                    print(String(describing: error))
                    
                }
            } // Servis bizden herhangi bir bilgi istemediği için metod 'GET'olarak işaretlendi.
        }
        
    }
    func sepeteYemekEkle(yemek_adi:String,yemek_fiyat:String,yemek_resim_adi: String,yemek_siparis_adet:String,kullanici_adi:String = "oguz_kanda"){
        
        let params:Parameters = ["yemek_adi":yemek_adi,"yemek_fiyat":yemek_fiyat,"yemek_resim_adi":yemek_resim_adi, "yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post,parameters: params).response {
            response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetCRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj  : \(cevap.message!)")
                    
                } catch {
                    print(String(describing: error))
                }
            }
        }
    } // Servis bizden bilgi istediği için metod 'POST'olarak işaretlendi.
    
    func sepettekiYemekleriGetir(kullanici_adi:String = "oguz_kanda"){
        
        let params:Parameters = ["kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post,parameters: params).response {
            response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let liste = cevap.sepet_yemekler{
                        self.sepettekiYemekler.onNext(liste)//Tetikleme
                    }
                }catch {
                    print(String(describing: error))
                    
                }
            }
        }
    } // Servis bizden bilgi istediği için metod 'POST'olarak işaretlendi.
    
    func sil(sepet_yemek_id:String, kullanici_adi:String){
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post,parameters: params).response {
            response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj  : \(cevap.message!)")
                    self.sepettekiYemekleriGetir(kullanici_adi: "oguz_kanda")

                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}


