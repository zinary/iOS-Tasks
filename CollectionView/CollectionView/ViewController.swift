//
//  ViewController.swift
//  CollectionView
//
//  Created by Janakiraman Kanagaraj on 02/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [String] = []
    var image : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        for i in 1...90
        {
            data.append("\(i)")
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuse", for: indexPath) as! CollectionViewCell
        
        let cellIndex = indexPath.item

        cell.imageView.image = UIImage(named: data[cellIndex])
        cell.contentView.backgroundColor = .black
        cell.titleView.textColor = .white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.titleView.text = data[cellIndex]
        return cell
    }
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
   
    
}
extension ViewController : UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    }
//
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.red
        
//        let alertController = UIAlertController(title: "Hint", message: "selected item \(indexPath.item+1)", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil )
//        alertController.addAction(alertAction)
//        present(alertController, animated: true, completion: nil)
//        collectionView.deselectItem(at: indexPath , animated: true)
     
    }

}

