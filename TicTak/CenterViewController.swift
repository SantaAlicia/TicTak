//
//  ViewController.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var gameOverInfo: UILabel!
    @IBOutlet weak var gameInfo: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    private var embeddedViewController: CollectionViewController!
    var delegate : CenterViewControllerLeftPanel?
    
    private let sectionInsets = UIEdgeInsets(top: 0.0,
    left: 0.0,
    bottom: 0.0,
    right: 0.0)
    
    private let itemsPerRow: CGFloat = 3
    //let game = Game.shared
    var gameTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tuningView()
        preparationViewsAndContols()
        //stackView.addBackground(color: UIColor.lightGray)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CollectionViewController,
                    segue.identifier == "collectionViewSegue" {
            self.embeddedViewController = vc
        }
    }
    
    func tuningView () {
//        embeddedViewController.view.layer.shadowOpacity = 0.2
//        embeddedViewController.view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        embeddedViewController.view.layer.shadowRadius = 5
//        embeddedViewController.view.layer.shadowColor = UIColor.blue.cgColor
        makeShadow(control : embeddedViewController.view)
        makeShadow(control : startButton)
        makeShadow(control : gameInfo)
        makeShadow(control : gameOverInfo)

        startButton.layer.cornerRadius = DesignConstants.cornerRadius
        startButton.clipsToBounds = true
        
        embeddedViewController.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "notebookBackground")!)
       // embeddedViewController.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "settings1")!)
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "woodBackground")!)
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "oldBook1")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "oldBook1")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        //playWithComputerSwitch.onTintColor = .black
        //playWithComputerSwitch.tintColor = .black
        
        self.title = "Tic-Tac-Toe"
    }
    
    @IBAction func startNewGameButtonPressed(_ sender: Any) {
        startNewGame()
    }
    
    @IBAction func burgerMenuTapped() {
        delegate?.toggleLeftPanel()
    }
}

extension CenterViewController {
    
    private func startNewGame() {
        Game.shared.startNewGame()
            preparationViewsAndContols()
            embeddedViewController.collectionView.isUserInteractionEnabled = true
    }
    
    private func preparationViewsAndContols() {
            embeddedViewController.collectionView.reloadData()
            updateInfoLabels()
            //updateEnabledControls()
    }
        
    func playerMakesOneTurn(_ i : Int) {
        if !(Game.shared.playerMakesTurnAtIndex(i)) {
            return
        }
        if ((Game.shared.playVSComputer) && (Game.shared.currentPlayer == Player.zero)) {
                gameTimer?.invalidate()
                gameTimer = nil
            }
            embeddedViewController.collectionView.reloadData()
            updateInfoLabels()
            //updateEnabledControls()
        }
}

extension CenterViewController {
    private func updateInfoLabels () {
        switch Game.shared.state {
        case GameState.isNotStarted, GameState.isStarted:
            gameInfo.text = "First Turn is of Player \"Cross\""
            //gameInfo.font = UIFont(name: "MarkerFelt-Thin", size: 18.0)
            gameInfo.textColor = .black
            gameOverInfo.text = " "
        case GameState.isProceed:
            gameInfo.text = currentPlayerText()
            gameOverInfo.text = " "
        case GameState.isOver:
            //gameInfo.font = UIFont(name: "MarkerFelt-Wide", size: 22.0)
            gameInfo.textColor = .black//.red
            
            //textInfo = GameResultController.winnerText()
            (gameInfo.text, gameOverInfo.text) = GameResultController.winnerText()
//            if game.playVSComputer {
//                if game.
//                gameOverInfo.text = "You Win!"
//            }
//            else {
//                gameOverInfo.text = "Game Over!"
//            }
        }
    }
    
    private func currentPlayerText() -> String {
        let textZero : String!
        if (!Game.shared.playVSComputer) {
            textZero =  "Turn of Player \"Zero\""
        } else  {
            textZero = " "  }
        switch Game.shared.currentPlayer {
        case Player.cross:
            return "Turn of Player \"Cross\""
            
        case Player.zero:
            return textZero
        }
    }
    
    private func updateEnabledControls() {
        switch Game.shared.state {
        case GameState.isNotStarted:
            startButton.isEnabled = true
            
        case GameState.isStarted:
            startButton.isEnabled = false
            
        case GameState.isProceed:
            startButton.isEnabled = false
            
        case GameState.isOver:
            startButton.isEnabled = true
        }
    }
    
    private func makeShadow(control : UIView) {
        control.layer.shadowOpacity = 0.2
        control.layer.shadowOffset = CGSize(width: 0, height: 0)
        control.layer.shadowRadius = 5
        control.layer.shadowColor = UIColor.blue.cgColor
        control.layer.masksToBounds = false;
    }

//    private func udateCellsIfGameOver() {
//        if game.state != GameState.isOver {
//            return
//        }
//        //let set : Set<Int>? = game.winSet()
//        let indexPath = IndexPath(item: 1, section: 0)
//
//        let a = collectionView.cellForItem(at: indexPath)
//
//        if let cell = ((collectionView.cellForItem(at: indexPath)) as? TicTacCollectionViewCell) {
//            cell.imageView.image = UIImage(named: "scratch")
//        }
//    }
}

//extension CenterViewController : LeftMenuViewControllerelDelegate {
//    func didSelectMenu() {
//    }
//}

protocol CenterViewControllerLeftPanel {
  func toggleLeftPanel()
}


