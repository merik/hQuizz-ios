//
//  DashboardViewController.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBAction func didTapOnPlay(_ sender: Any) {
        prepareForNewGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func prepareForNewGame() {
        let repository = ApiRepository()
        let game = Game(repository: repository)
        game.newGame(completion: {[weak self] status in
            switch status {
            case .error(let message):
                self?.handleErrorMessage(with: message)
            case .ready:
                DispatchQueue.main.async {
                    self?.startGame(game)
                }
                
            }
        })
    }
    
    private func startGame(_ game: Game) {
        let viewModel = QuestionsViewModel(game: game)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "questions") as! QuestionsViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.viewModel = viewModel
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func handleErrorMessage(with message: String) {
        
    }

}
