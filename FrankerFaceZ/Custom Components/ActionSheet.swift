//
//  ActionSheet.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/5/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

extension EmoteSearchVC {
    
    func updatePage() {
        //tableView.prefetchDataSource
        pageNumber = 1
        showLoadingView()
        NetworkManager.shared.getPage(search: self.searchString, pageNumber: pageNumber) { (emotes, pages) in
            self.dismissLoadingView()
            guard emotes!.count != 0 else {
                self.presentGFAlertOnMainThread(title: "Error loading emotes", message: "Something went wrong. Please try again.", buttonTitle: "Ok")
                return
            }
            self.pageEmotes = emotes!
            self.totalPages = pages
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            self.updateUI()
            print(EmoteSearchVC.sortString)
        }
    }
    
    enum ButtonChecked {
        case first
        case second
        case third
        case fourth
        case fifth
        case sixth
        case senventh
        case eighth
        case nineth
        case tenth
    }
    
    func createActionSheet(searchString:String) -> UIAlertController {
        
        let optionMenu = UIAlertController(title: nil, message: "Sort By", preferredStyle: .actionSheet)
        
        //let view = UIView(frame: CGRect(x: 8.0, y: 8.0, width: optionMenu.view.bounds.size.width - 8.0 * 4.5, height: 120.0))
        //view.backgroundColor = .systemBackground
        optionMenu.view.tintColor = .systemPurple
       // optionMenu.view.addSubview(view)
        
        let createdAscending = UIAlertAction(title: "Created At, Ascending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "created-asc"
            self.buttonChecked = .first
            self.updatePage()
        })
        let createdDescending = UIAlertAction(title: "Created At, Descending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "created-desc"
            self.buttonChecked = .second
            self.updatePage()
        })
        let updatedAscending = UIAlertAction(title: "Last Updated, Ascending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "updated-asc"
            self.buttonChecked = .third
            self.updatePage()
        })
        let updatedDescending = UIAlertAction(title: "Last Updated, Descending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "updated-desc"
            self.buttonChecked = .fourth
            self.updatePage()
        })
        let nameAscending = UIAlertAction(title: "Name, Ascending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "name-asc"
            self.buttonChecked = .fifth
            self.updatePage()
        })
        let nameDescending = UIAlertAction(title: "Name, Descending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "name-desc"
            self.buttonChecked = .sixth
            self.updatePage()
        })
        let ownerAscending = UIAlertAction(title: "Owner, Ascending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "owner-asc"
            self.buttonChecked = .senventh
            self.updatePage()
        })
        let ownerDescending = UIAlertAction(title: "Owner, Descending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "owner-desc"
            self.buttonChecked = .eighth
            self.updatePage()
        })
        let usageAscending = UIAlertAction(title: "Usage Count, Ascending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "count-asc"
            self.buttonChecked = .nineth
            self.updatePage()
        })
        let usageDescending = UIAlertAction(title: "Usage Count, Descending", style: .default, handler: { action in
            EmoteSearchVC.sortString = "count-desc"
            self.buttonChecked = .tenth
            self.updatePage()
        })
        
//        let ascendingDescending = UIAlertAction(title: ascDesc, style: .default) { (action) in
//            if self.ascDesc == "descending" {
//                self.ascDesc = "ascending"
//            }
//            else if self.ascDesc == "ascending" {
//                self.ascDesc = "descending"
//            }
//        }
        
        switch buttonChecked {
        case .first:
            createdAscending.setValue(true, forKey: "checked")
        case .second:
            createdDescending.setValue(true, forKey: "checked")
        case .third:
            updatedAscending.setValue(true, forKey: "checked")
        case .fourth:
            updatedDescending.setValue(true, forKey: "checked")
        case .fifth:
            nameAscending.setValue(true, forKey: "checked")
        case .sixth:
            nameDescending.setValue(true, forKey: "checked")
        case .senventh:
            ownerAscending.setValue(true, forKey: "checked")
        case .eighth:
            ownerDescending.setValue(true, forKey: "checked")
        case .nineth:
            usageAscending.setValue(true, forKey: "checked")
        case .tenth:
            usageDescending.setValue(true, forKey: "checked")
        }

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        optionMenu.addAction(createdAscending)
        optionMenu.addAction(createdDescending)
        optionMenu.addAction(updatedAscending)
        optionMenu.addAction(updatedDescending)
        optionMenu.addAction(nameAscending)
        optionMenu.addAction(nameDescending)
        optionMenu.addAction(ownerAscending)
        optionMenu.addAction(ownerDescending)
        optionMenu.addAction(usageAscending)
        optionMenu.addAction(usageDescending)
       // optionMenu.addAction(ascendingDescending)
        optionMenu.addAction(cancelAction)
        
        return optionMenu
    }
}
