//
//  TeamCell.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 20..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
  
  var imgView = UIImageView()
  var titleLabel = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    self.contentView.addSubview(imgView)
    self.contentView.addSubview(titleLabel)
    
    imgView.snp.makeConstraints { (make) in
      make.left.equalTo(self.contentView).offset(2)
      make.width.height.equalTo(20)
      make.centerY.equalTo(self.contentView)
    }
    
    titleLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(self.contentView)
      make.height.equalTo(20)
      make.left.equalTo(imgView.snp.right).offset(5)
      make.right.equalTo(self.contentView).offset(-2)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureCell(indexPath: IndexPath) {
    guard let clubs = ClubDataService.instance.leagues[indexPath.section].clubs else { return }
    let club = clubs[indexPath.row]
    titleLabel.text = club.name
  }
  
}
