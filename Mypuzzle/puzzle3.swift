//
//  puzzle3.swift
//  Mypuzzle
//
//  Created by 141220138_141220132 on 17/1/10.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation
import UIKit

class Puzzle3: UIViewController{
    public var kCol = 2
    public var kImgWidth:CGFloat = 0
    public var screenwidth:CGFloat=0;
    public var screenheight:CGFloat=0;
    
    public var imgViewArr: [UIImageView] = []
    
    public var rotateInfo: [Int] = []
    
    //添加手势
    func addSwipe(View imgView : UIImageView ){
    
        let swipe = UITapGestureRecognizer(target: self, action: #selector(swipe(_:)))
        imgView.addGestureRecognizer(swipe)
        imgView.isUserInteractionEnabled = true
        
    }
    
    //处理手势
    func swipe(_ sender :UITapGestureRecognizer){
        
        for i in 0..<(kCol * kCol){
            if(rotateInfo[i]%4 != 0){
                break
            }
            if(i == kCol*kCol-1){
                return
            }
        }

        
        let imgView:UIImageView = sender.view as! UIImageView
        let idx = imgViewArr.index(of: imgView)!
       
        rotateInfo[idx] += 1;
        
        imgView.transform = imgView.transform.translatedBy(x: 0, y: 0)
        
        imgView.transform = imgView.transform.rotated(by: CGFloat(M_PI_2))
        
     //   imgView.transform = CGAffineTransform(rotationAngle: 90);
    }
    
    
    //打乱图片
    func disOrderImage(){
        
        for i in 0..<(kCol * kCol){
            rotateInfo[i]=0;
        }
        
        for _ in 0..<20{
            
            let idx = Int( arc4random() % UInt32(kCol * kCol) )
            let times = Int( arc4random() % UInt32(6) )
            
            let imgView = imgViewArr[idx]
            
            rotateInfo[idx]+=times;
            
            for _ in 0..<times{
                UIView.animate(withDuration: 1, animations: { () -> Void in
                    imgView.transform = imgView.transform.translatedBy(x: 0, y: 0)
                    
                    imgView.transform = imgView.transform.rotated(by: CGFloat(M_PI_2))
                    
                })
            }
            
            
        }
        
    }
    
    //剪裁图片
    func clipImg(_ img: UIImage, col: Int, row: Int, idx: Int) -> UIImage{
        
        let cgImgH = CGFloat( (img.cgImage?.height)! )
        let cgImgW = CGFloat( (img.cgImage?.width)! )
        
        
        let eleH = cgImgH / CGFloat(row)
        let eleW = cgImgW / CGFloat(col)
        
        let space = eleH < eleW ? eleH : eleW
        let topX = (cgImgW - space * CGFloat(col)) * 0.5
        let topY = (cgImgH - space * CGFloat(row)) * 0.5
        let X = topX + space * CGFloat(idx % col)
        let Y = topY + space * CGFloat(idx / col)
        
        let rect = CGRect(x: X, y: Y, width: space, height: space)
        
        let cgImg = img.cgImage?.cropping(to: rect)
        
        return UIImage(cgImage: cgImg!)
    }
    
}
