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
        
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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

        let isCurrentPosition = (game.currentPosition == indexPath.row)
           collectionCell.fillCell(type : game.gameBoard.cellAtIndex(indexPath.row).type, isWinCell: isWinCell, isCurrent: isCurrentPosition)
           return collectionCell
       }
   }

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vcParent = self.parent as! CenterViewController
        vcParent.playerMakesOneTurn(indexPath.row)

        if (game.state == GameState.isOver) {
            gameOver_doSomething(vcParent)
            return
        }
        if ((game.playVSComputer) && (game.currentPlayer == Player.zero)) {
            doOneTurnForZeroPlayer(vcParent)
        }
    }
    
    private func gameOver_doSomething (_ vcParent: CenterViewController) {
        collectionView.isUserInteractionEnabled = false
    }
    
    private func doOneTurnForZeroPlayer(_ vcParent: CenterViewController) {
        var indexForNextStep : Int? = 0
        collectionView.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        let r = GameResultController.doSmartDecision()
        if (r.0) {
            indexForNextStep = r.1 // logical
        } else {
            indexForNextStep = game.gameBoard.findOneEmptyCell() //it is random
        }
        guard !(indexForNextStep == nil) else {return}
        
        let delayInSeconds = 1.1

        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            guard let self = self else {
                return
            }
            vcParent.playerMakesOneTurn(indexForNextStep!)
            if (Game.shared.state != GameState.isOver) {
                      self.collectionView.isUserInteractionEnabled = true
            }
            self.activityIndicator.stopAnimating()
        }
        
        self.navigationController?.viewIfLoaded?.setNeedsLayout()
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

