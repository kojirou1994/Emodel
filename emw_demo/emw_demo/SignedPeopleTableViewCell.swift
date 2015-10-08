//
//  SignedPeopleTableViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/22.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit

class SignedPeopleTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var people: [String]?
    var fatherVC: NoticeDetailViewController!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    @IBOutlet weak var noPeopleLabel: UILabel!
    override func awakeFromNib() {
        print("cell awake From Nib")
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell() {
        print(people)
        noPeopleLabel.hidden = people != nil
        print(noPeopleLabel.hidden)
        peopleCollectionView.hidden = people == nil
        print(peopleCollectionView.hidden)
        self.peopleCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count")
        print(people?.count)
        return people == nil ? 0 : people!.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SignedPeopleCell", forIndexPath: indexPath) as! SignedPeopleCollectionViewCell
        cell.setAvatarImage(people![indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Chat") as! ChatViewController
        chat.targetUserID = people![indexPath.row]
        self.fatherVC.navigationController?.pushViewController(chat, animated: true)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(40, 40)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 10)
        
    }
    
}
