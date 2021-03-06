//
//  CustomCell.swift
//  ChookDuck Widget
//
//  Created by junwoo on 2017. 10. 13..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

protocol CheckBtnDelegate: class {
  func checkBtnDidTap(sender: UIButton)
}

extension CheckBtnDelegate {
  func checkBtnDidTap(sender: UIButton) {}
}

class CustomCell: UITableViewCell {
  
  @IBOutlet weak var newsImg: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var checkBtn: UIButton!
  weak var checkBtndelegate: CheckBtnDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    checkBtn.isSelected = false
  }
  
  func setupView() {
    //self.layer.backgroundColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 10
    //이미지가 셀 밖으로 안 삐져나가도록
    self.clipsToBounds = true
    checkBtn.addTarget(self, action: #selector(checkBtnDidTap), for: .touchUpInside)
  }
  
  func configureClubCell(index: Int) {
    if let imgSrc = DataService.instance.clubArticles[index].articleImg {
      fetchImage(src: imgSrc)
    }
    titleLabel.text = DataService.instance.clubArticles[index].articleTitle
  }
  
  func configurePlayerCell(index: Int) {
    if let imgSrc = DataService.instance.playerArticles[index].articleImg {
      fetchImage(src: imgSrc)
    }
    titleLabel.text = DataService.instance.playerArticles[index].articleTitle
  }
  
  func fetchImage(src: String) {
    let imageURL = URL(string: src)
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: imageURL!) { (data, response, error) in
      
      if let e = error {
        print("error : ", e)
      } else {
        if (response as? HTTPURLResponse) != nil {
          
          if let imageData = data {
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
              self.newsImg.image = image
            }
            
          } else {
            print("cannot find image")
          }
        } else {
          print("no response from server")
        }
      }
      
    }
    
    task.resume()
  }
  
  @objc func checkBtnDidTap() {
    self.checkBtndelegate?.checkBtnDidTap(sender: checkBtn)
  }

}
