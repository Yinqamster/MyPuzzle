//
//  FZImagePicker.swift
//  Mypuzzle
//
//  Created by 141220138_141220132 on 17/1/11.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation
import UIKit

//选择图片成功后，调用该代理方法获取图片信息
protocol FZImagePickerDelegate {
    func imagePickerDidSelectedImage(imagePick: FZImagePicker, didFinishPickingMediaWithInfo info: [String : Any])
}

class FZImagePicker:NSObject, UINavigationControllerDelegate{
    
    //设置代理对象
    var delegate: FZImagePickerDelegate!
    //设置视图控制器对象
    var viewController: UIViewController!
    //弹出ActionSheet ，让用户选择图片来源：相机或相册
    public func showImagePick() {
        let alertview = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler:nil)
        let action1 = UIAlertAction(title: "相册", style: UIAlertActionStyle.default) {
            (action: UIAlertAction!) -> Void in
            self.openAlbum()
        }
        let action2 = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) {
            (action: UIAlertAction!) -> Void in
            self.openCamera()
        }
        alertview.addAction(action1)
        alertview.addAction(action2)
        alertview.addAction(cancelAction)
        
        alertview.popoverPresentationController?.sourceView = viewController.view
 //       alertview.popoverPresentationController?.sourceRect = (tableView.cellForRow(at: indexPath)?.frame)!
  //      alertview.popoverPresentationController?.barButtonItem = viewController.saveBarButtomItem
        
        viewController.present(alertview, animated: true, completion: nil)
    }
    
    private func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.allowsEditing = true
            viewController.present(picker, animated: true, completion: nil)
        }else{
            //此处可做优化，弹出提示框提示用户错误
            debugPrint("读取相册错误")
        }
    }
    
    private func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.allowsEditing = true
            viewController.present(picker, animated: true, completion: nil)
        }else{
            //此处可做优化，弹出提示框提示用户错误
            debugPrint("找不到相机")
        }
    }
    
}
//MARK: - UIImagePickerControllerDelegate
extension FZImagePicker: UIImagePickerControllerDelegate{
    //系统的代理方法返回图片信息，将图片信息传递给自身代理对象，根据需要可对图片进行相应的处理，
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.delegate.imagePickerDidSelectedImage(imagePick: self, didFinishPickingMediaWithInfo: info)
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
