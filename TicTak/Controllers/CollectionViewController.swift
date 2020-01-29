//
//  CollectionViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 28/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "ticTakCell"
    let game = Game.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CollectionViewController: UICollectionViewDataSource {

       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return GameConstants.gameDimension
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TicTacCollectionViewCell

           collectionCell.layer.borderColor = UIColor.lightGray.cgColor
           
           collectionCell.isUserInteractionEnabled = true
           let isWinCell = game.isCellInsideWinCombination(index: indexPath.row)

           collectionCell.fillCell(type : game.gameBoard.cellAtIndex(indexPath.row).type, isWinCell: isWinCell )
           return collectionCell
       }
   }

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let vcParent = self.parent as! ViewController
                vcParent.playerMakesOneMove(indexPath.row)
                if (game.state == GameState.isOver) {
                    vcParent.gameTimer?.invalidate()
                    vcParent.gameTimer = nil
                    collectionView.isUserInteractionEnabled = false
                    return
                }
                    if ((vcParent.playWithComputerSwitch.isOn) && (game.currentPlayer == Player.zero)) {
                    
                    guard let ramdomIndexFromEmptyCell = game.gameBoard.findOneEmptyCell() else {
                        return
                    }

                        vcParent.gameTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { timer in
                        vcParent.playerMakesOneMove(ramdomIndexFromEmptyCell)
                    })
                }
            }
}

extension CollectionViewController : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//      //2
//      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//      let availableWidth = view.frame.width - paddingSpace
//      let widthPerItem = availableWidth / itemsPerRow
//
//      return CGSize(width: widthPerItem, height: widthPerItem)
//    }
    
//    //3
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//      return sectionInsets
//    }
//
//    // 4
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//      return sectionInsets.left
//    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let nbCol = 3
        

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        
//        print("***")
//             print(collectionView.bounds.size.width)
//             print(collectionView.bounds.size.height)
        
        let w = collectionView.bounds.size.width
        collectionView.bounds.size = CGSize(width: w, height: w)
        return CGSize(width: size, height: size)
    }
}
