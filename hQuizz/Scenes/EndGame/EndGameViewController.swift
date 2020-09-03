//
//  EndGameViewController.swift
//  hQuizz
//
//  Created by Erik Mai on 3/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

protocol EndGameViewControllerDelegate: class {
    func endGame(_ viewController: EndGameViewController)
}

class EndGameViewController: UIViewController {

    var totalScore = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var leaderboardsButton: hQuizzButton!
    weak var delegate: EndGameViewControllerDelegate?
    
    @IBAction func didTapOnExitGame(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        delegate?.endGame(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "\(totalScore)"
        setLeaderboardsButtonText()
    }
    
    private func setLeaderboardsButtonText() {
        let stringAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor : UIColor.white]
        let leaderboardsAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .heavy), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let titleText = NSMutableAttributedString(string: "How am I doing in the ", attributes: stringAttrs)
        let leaderboardsString = NSMutableAttributedString(string: "leaderboards?", attributes: leaderboardsAttrs)
        
        titleText.append(leaderboardsString)
        leaderboardsButton.setAttributedTitle(titleText, for: .normal)
    }
    


}
