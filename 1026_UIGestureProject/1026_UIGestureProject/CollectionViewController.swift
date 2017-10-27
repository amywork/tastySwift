//
//  CollectionViewController.swift
//  1026_UIGestureProject
//
//  Created by 김기윤 on 27/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    /*UI Property*/
    var wordData: [String] = ["Z","I","A","C","O","D","E","A","N","C","R","U","S","H","F","A","N","X","Y","🙈"]
    var colorData: [UIColor] = [#colorLiteral(red: 0.2486523092, green: 0.5937342048, blue: 1, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 1, green: 0.1615929008, blue: 0.3309845924, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.9749191403, green: 0.1620492339, blue: 0.4109461904, alpha: 1),#colorLiteral(red: 1, green: 0.1615929008, blue: 0.3309845924, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)]
    
    /*Life-Cycle*/
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.allowsMultipleSelection = true
    }
    
    /*Button Method*/
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        collectionView?.reloadData()
    }
    
    @IBAction func deleteAction(_ sender: UIBarButtonItem) {
        if let indexPaths = collectionView?.indexPathsForSelectedItems {
            let sortedIndexPath = indexPaths.sorted(by: { (path1, path2) -> Bool in
                return path1.item > path2.item
            })
            collectionView?.performBatchUpdates({
                collectionView?.deleteItems(at: indexPaths)
                for index in sortedIndexPath {
                    wordData.remove(at: index.item)
                }
            }, completion: nil)
        }
        /*무조건 첫 번째 데이터를 지우는 방법*/
        /*if wordData.count > 0 {
            collectionView?.performBatchUpdates({
                let index = IndexPath(item: 0, section: 0)
                wordData.removeFirst()
                collectionView?.deleteItems(at: [index])
            }, completion: nil)
        }*/
    }
    
    /*중간에 데이터를 넣는 방법*/
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        collectionView?.performBatchUpdates({
            let index = IndexPath(item: wordData.count/2, section: 0)
            wordData.insert("♥️", at: wordData.count/2)
            collectionView?.insertItems(at: [index])
        }, completion: nil)
    }
    
    /*사이즈 Property*/
    var viewWidth: CGFloat {
        return collectionView!.bounds.width
    }
    
    var viewHeight: CGFloat {
        return collectionView!.bounds.height
    }
    
    var cellWidth: CGFloat {
        return viewWidth*0.24
    }
    
    var cellHeight: CGFloat {
        return cellWidth
    }

    
	/*CollectionView DataSource*/
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordData.count
    }

    /*cellForItemAt*/
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.data = wordData[indexPath.item]
        cell.isSelected = false
        cell.backgroundColor = colorData[indexPath.row%20]
        return cell
    }
    
    /*sizeForItemAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    /*minimumInteritemSpacingForSectionAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    /*minimumLineSpacingForSectionAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    /*didSelectItemAt*/
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt", indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        cell?.isSelected = true
    }
    
    /*didDeselectItemAt*/
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("didDeselectItemAt", indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        cell?.isSelected = false
    }

}
