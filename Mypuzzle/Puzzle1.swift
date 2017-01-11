//
//  Puzzle1.swift
//  Mypuzzle
//
//  Created by 141220138_141220132 on 2016/11/24.
//  Copyright © 2016年 nju. All rights reserved.
//

import Foundation
import UIKit

extension Array{
    mutating func exchangeObj(idx: Int, toIdx: Int){
        
        let obj1 = self[idx]
        let obj2 = self[toIdx]
        
        replaceSubrange(idx...idx, with: [obj2])
        replaceSubrange(toIdx...toIdx, with: [obj1])
        
    }
}

class Puzzle1: UIViewController{
    public var kCol = 2
    public var kImgWidth:CGFloat = 0
    public var screenwidth:CGFloat=0;
    public var screenheight:CGFloat=0;
    
    public var imgViewArr: [UIImageView] = []
    public var pointInfo: [CGPoint] = []
    
    //添加手势
    func addSwipe(View imgView : UIImageView ,direction : UISwipeGestureRecognizerDirection){
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipe.direction = direction
        imgView.addGestureRecognizer(swipe)
        imgView.isUserInteractionEnabled = true
        
    }
    
    //处理手势
    func swipe(_ sender :UISwipeGestureRecognizer ){
        
   /*     for i in 0..<(kCol * kCol){
            let x1=imgViewArr[i].frame.midX;
            let x2=pointInfo[i].x;
            let y1=imgViewArr[i].frame.midY;
            let y2=pointInfo[i].y;
            
            if(abs(x1-x2)>1||abs(y1-y2)>1){
                break
            }
            
            if(i==kCol*kCol-1){
                
                return
            }
        }*/

        
        let imgView:UIImageView = sender.view as! UIImageView
        let idx = imgViewArr.index(of: imgView)!
        //        print(idx)
        
        if sender.direction == .right {
            swipeExchange(idx: idx, row: 0, col: 1)
        }
        
        if sender.direction == .left {
            swipeExchange(idx: idx, row: 0, col: -1)
        }
        
        if sender.direction == .up {
            swipeExchange(idx: idx, row: -1, col: 0)
        }
        
        if sender.direction == .down {
            swipeExchange(idx: idx, row: 1, col: 0)
        }
        
    }
    
    func swipeExchange(idx :Int ,row :Int ,col :Int){
        
        let newCol = idx % kCol + col
        let newRow = idx / kCol + row
        //        print("newCol",newCol,"newRow",newRow,"idx",idx)
        //越界
        if newCol < 0 || newCol > kCol - 1 || newRow < 0 || newRow > kCol - 1 {
            return
        }
        
        let newIdx = newCol + newRow * kCol
        let imgView = imgViewArr[idx]
        let imgV = imgViewArr[newIdx]
        //        print("swipeRight",col)
        
        //为空
        if imgV.image != nil{
            return
        }
        
        //交换数组
        //        imgViewArr.removeAtIndex(idx)
        //        imgViewArr.insert(imgV, atIndex: idx)
        //        imgViewArr.removeAtIndex(newIdx)
        //        imgViewArr.insert(imgView, atIndex: newIdx)
        
        imgViewArr.exchangeObj(idx: idx, toIdx: newIdx)
        
        let frame = imgV.frame
        imgV.frame = imgView.frame
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            imgView.frame = frame
        })
        
    }
    
    //打乱图片
    func disOrderImage(){
        
        for _ in 0..<20{
            
            let idx1 = Int( arc4random() % UInt32(kCol * kCol) )
            let idx2 = Int( arc4random() % UInt32(kCol * kCol) )
            
            let imgView = imgViewArr[idx1]
            let imgV = imgViewArr[idx2]
           
            
            let frame = imgV.frame
            UIView.animate(withDuration: 1, animations: { () -> Void in
                imgV.frame = imgView.frame
                imgView.frame = frame
            })
            
            imgViewArr.exchangeObj(idx: idx1, toIdx: idx2)
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
