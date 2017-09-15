//
//  ViewController.swift
//  PicuturePreview
//
//  Created by Hiroki Taniguchi on 2017/09/14.
//  Copyright © 2017年 Hiroki Taniguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    let photoStringArray = ["a","b","c","d","e","f","g","h"]
    var selectedImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoStringArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGFloat = self.view.frame.size.width/2
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as UICollectionViewCell
        let cellImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let cellimage = UIImage(named:photoStringArray[indexPath.row])
        cellImageView.image = cellimage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = UIImage(named:photoStringArray[indexPath.row])
        if selectedImage != nil {
            performSegue(withIdentifier: "toPreview",sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toPreview") {
            let navigationViewController = segue.destination as! UINavigationController
            let preVC = navigationViewController.viewControllers[0] as! PreviewViewController
            preVC.selectedImage = selectedImage
        }
    }
}

