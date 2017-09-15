//
//  PreviewViewController.swift
//  PicuturePreview
//
//  Created by Hiroki Taniguchi on 2017/09/14.
//  Copyright © 2017年 Hiroki Taniguchi. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var selectedImage : UIImage?
    var allPreviewFlag = false
    
    @IBOutlet weak var previewScrollView: UIScrollView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBottomBarWhenPushed = true
        navigationController?.popViewController(animated: true)
        
        // スクロールビューの設定
        self.previewScrollView.delegate = self
        self.previewScrollView.minimumZoomScale = 1
        self.previewScrollView.maximumZoomScale = 8
        self.previewScrollView.isScrollEnabled = true
        self.previewScrollView.showsHorizontalScrollIndicator = true
        self.previewScrollView.showsVerticalScrollIndicator = true
        
        myInit()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action:#selector(self.doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        self.previewImageView.addGestureRecognizer(doubleTapGesture)
        let singleTapGesture = UITapGestureRecognizer(target: self, action:#selector(self.singleTap))
        singleTapGesture.numberOfTapsRequired = 1
        self.previewImageView.addGestureRecognizer(singleTapGesture)
    }
    
    func myInit() {
        // 画像を読み込んで配置する
        if selectedImage != nil{
            previewImageView?.image = selectedImage
            previewImageView?.isUserInteractionEnabled = true
            previewImageView?.contentMode = UIViewContentMode.scaleAspectFit
        }else {
            print("写真がない")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //print("pinch")
        return self.previewImageView
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        //print(self.myScrollView.zoomScale)
        if (self.previewScrollView.zoomScale < self.previewScrollView.maximumZoomScale) {
            let newScale = self.previewScrollView.zoomScale * 3
            let zoomRect = self.zoomRectForScale(scale: newScale, center: gesture.location(in: gesture.view))
            self.previewScrollView.zoom(to: zoomRect, animated: true)
        } else {
            self.previewScrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        let size = CGSize(
            width: self.previewScrollView.frame.size.width / scale,
            height: self.previewScrollView.frame.size.height / scale
        )
        return CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
    }
    
    func singleTap(gesture: UITapGestureRecognizer) -> Void {
        if self.previewScrollView.zoomScale == 1.0{
            print("ズーム無し状態")
            chengeHederandFoter()
        }else {
            print("ズームあり状態")
            chengeHederandFoter()
        }
    }
    
    func chengeHederandFoter(){
        if allPreviewFlag == false {
            toolBar.isHidden = true
            navigationController?.navigationBar.isHidden = true
            allPreviewFlag = true
            previewScrollView.backgroundColor = UIColor(hex: "000000")
        }else {
            toolBar.isHidden = false
            navigationController?.navigationBar.isHidden = false
            allPreviewFlag = false
            previewScrollView.backgroundColor = UIColor(hex: "FAFAFA")
        }
    }
    
    @IBAction func tapShareButton(_ sender: Any) {
        print("tapShareButton")
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        print("tapSaveButton")
    }
    
    @IBAction func tapDelateButton(_ sender: Any) {
        print("tapDelateButton")
    }
}
