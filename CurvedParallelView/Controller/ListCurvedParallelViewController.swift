//
//  ListCurvedParallelViewController.swift
//  CurvedParallelView
//
//  Created by HP on 6/29/18.
//  Copyright © 2018 rth. All rights reserved.
//

import UIKit

class ListCurvedParallelViewController: UIViewController {

    @IBOutlet weak var listCurvedParallelTableView: UITableView!
    
    var themes: [ParallelTheme] = []
    let palette1 = [UIColor(rgb: 0x74dbef), UIColor(rgb: 0xeff0f4), UIColor(rgb: 0x264e86)]
    let palette2 = [UIColor(rgb: 0x17bebb), UIColor(rgb: 0x2e282a), UIColor(rgb: 0xedb88b)]
    let palette3 = [UIColor(rgb: 0x35477d), UIColor(rgb: 0xc06c84), UIColor(rgb: 0xf67280)]
    let palette4 = [UIColor(rgb: 0x1a2c5b), UIColor(rgb: 0x3e4e88), UIColor(rgb: 0xb8dff0)]
    let palette5 = [UIColor(rgb: 0xf85f73), UIColor(rgb: 0xfbe8d3), UIColor(rgb: 0x283c63)]
    
    let palette6 = [UIColor(rgb: 0x0d7e83), UIColor(rgb: 0x13293d), UIColor(rgb: 0xffaf87)]
    let palette7 = [UIColor(rgb: 0x616161), UIColor(rgb: 0xc4e3cb), UIColor(rgb: 0x8aae92)]
    let palette8 = [UIColor(rgb: 0x42291c), UIColor(rgb: 0xb8e4c9), UIColor(rgb: 0xe9fadd)]
    let palette9 = [UIColor(rgb: 0x062743), UIColor(rgb: 0xff7a8a), UIColor(rgb: 0xf9f9f9)]
    let palette10 = [UIColor(rgb: 0x232931), UIColor(rgb: 0x4ecca3), UIColor(rgb: 0xeeeeee)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        [palette1, palette2, palette3, palette4, palette5, palette6, palette7, palette8, palette9, palette10].forEach({
            for i in 0...$0.count-1{
                if i % 3 == 0{
                    let theme = ParallelTheme(fillBackgroundColor: $0[(i + 1) % 3], curved: nil, imageBackground: UIImage(named: "568747-unsplash"), miniViewWidthPortition: nil, miniViewHeight: nil, miniViewContent: "Hubert Neufeld", miniViewBackgroundColor: $0[i % 3], miniViewContentColor: $0[(i + 2) % 3])
                    themes.append(theme)
                }else if i % 3 == 1{
                    let theme = ParallelTheme(fillBackgroundColor: $0[(i + 1) % 3], curved: nil, imageBackground: UIImage(named: "424233-unsplash"), miniViewWidthPortition: nil, miniViewHeight: nil, miniViewContent: "Nicole Honeywill", miniViewBackgroundColor: $0[i % 3], miniViewContentColor: $0[(i + 2) % 3])
                    themes.append(theme)
                }else{
                    let theme = ParallelTheme(fillBackgroundColor: $0[(i + 1) % 3], curved: nil, imageBackground: UIImage(named: "285895-unsplash"), miniViewWidthPortition: nil, miniViewHeight: nil, miniViewContent: "Scott Webb", miniViewBackgroundColor: $0[i % 3], miniViewContentColor: $0[(i + 2) % 3])
                    themes.append(theme)
                }
            }
        })
    }
    
    func initTableView(){
        setupTableView(tableView: listCurvedParallelTableView, delegate: self, datasource: self)
        listCurvedParallelTableView.separatorStyle = .none
    }
    
    func setupTableView(tableView: UITableView, delegate: UITableViewDelegate, datasource: UITableViewDataSource){
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }
}

extension ListCurvedParallelViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurvedParallelCell", for: indexPath) as! CurvedParallelCell
        cell.theme = themes[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(themes[indexPath.row].getColorPalatte())
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ListCurvedParallelViewController: OnTapButtonDelegate{
    func onTapButton(cell: CurvedParallelCell) {
        debugPrint("Tap info on cell)")
    }
}
