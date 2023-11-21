//
//  ViewController.swift
//  Bitirme Projesi
//
//  Created by Oğuz Kanda on 5.11.2023.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftUI

class Anasayfa: UIViewController {
    
    @IBOutlet weak var yemeklerTableView: UITableView!    
    var yemeklerListesi = [Yemekler]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar()
        yemeklerTableView.dataSource = self
        yemeklerTableView.delegate = self
                
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async {
                self.yemeklerTableView?.reloadData()
            }
        })
        
        if let tabBarItems = tabBarController?.tabBar.items {
            _ = tabBarItems[0]
            _ = tabBarItems[1]
       
        }
        
    
        let appearence = UITabBarAppearance()
        appearence.backgroundColor = UIColor.systemBackground
        
        renkDegistir(itemAppearence: appearence.stackedLayoutAppearance)
        renkDegistir(itemAppearence: appearence.compactInlineLayoutAppearance)
        renkDegistir(itemAppearence: appearence.inlineLayoutAppearance)

        tabBarController?.tabBar.standardAppearance = appearence
        tabBarController?.tabBar.scrollEdgeAppearance = appearence

    }
    
    func renkDegistir(itemAppearence:UITabBarItemAppearance) {
        
        // Seçili olduğu durumda
        itemAppearence.selected.iconColor = UIColor.systemYellow
        itemAppearence.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Seçili olmadığı durumda
        
        itemAppearence.normal.iconColor = UIColor.white
        itemAppearence.normal.badgeBackgroundColor = UIColor.red
        itemAppearence.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yemekleriYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let yemek = sender as? Yemekler {
                let gidilecekVC = segue.destination as! DetaySayfa
                gidilecekVC.yemek = yemek
            }
        }
    }
}
    
extension Anasayfa: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        yemeklerTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let yemek = yemeklerListesi[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yemeklerHucre") as! YemeklerTableView
        hucre.cellView.layer.cornerRadius = hucre.cellView.frame.height / 2
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            if let yemekAdi = hucre.yemekAdi, let yemekResim = hucre.yemekResim {
                yemekResim.kf.setImage(with: url)
                yemekAdi.text = yemek.yemek_adi
                hucre.yemekFiyat?.text = "\(yemek.yemek_fiyat!)₺"
                hucre.selectionStyle = .none
            }
        }
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
extension Anasayfa:UISearchBarDelegate {
    
    func searchBar() {
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.tintColor = UIColor.systemYellow
        searchBar.backgroundColor = UIColor.systemBackground
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Lütfen yemek ismi yazınız"
        self.yemeklerTableView.tableHeaderView = searchBar
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            viewModel.yemekleriYukle()
        
            } else {
                
                yemeklerListesi = yemeklerListesi.filter({ yemekler  in
                    return ((yemekler.yemek_adi?.contains(searchText)) ?? false)
            })
        }
        
        self.yemeklerTableView.reloadData()
        
    }
}


