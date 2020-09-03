//
//  QuestionsViewController.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
   
    @IBOutlet weak var bgImage: hQuizzBgImage!
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var answer1View: UIView!
    @IBOutlet weak var answer2View: UIView!
    @IBOutlet weak var answer3View: UIView!
    @IBOutlet weak var answer1Label: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    @IBOutlet weak var answer3Label: UILabel!
    @IBOutlet weak var standFirstLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var questionsProgressBar: hQuizzProgressBar!
    
    private let repository = ApiRepository()
    
    var viewModel: QuestionsViewModel!
    
    var responseViewController: ResponseViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        bindToViewModel()
        viewModel.startGame()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureViews() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "response") as! ResponseViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = self
        responseViewController = viewController
        
        sectionLabel.layer.cornerRadius = 5.0
        sectionLabel.clipsToBounds = true
        
        standFirstLabel.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(Self.didTapOnAnswer1))
        answer1View.isUserInteractionEnabled = true
        answer1View.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(Self.didTapOnAnswer2))
        answer2View.isUserInteractionEnabled = true
        answer2View.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(Self.didTapOnAnswer3))
        answer3View.isUserInteractionEnabled = true
        answer3View.addGestureRecognizer(tap3)
        
    }
    
    private func bindToViewModel() {
        viewModel.gameStatusUpdate = {[weak self] status in
            DispatchQueue.main.async {
                self?.updateUI(with: status)
            }
        }
    }
    
    private func updateUI(with status: QuestionsStatus) {
        switch status {
        case .loading:
            showLoading()
        case .endOfGame:
            showEndOfGame()
        case .error(let errorMessage):
            showErrorMessage(errorMessage)
        case .inGame(let question):
            showQuestion(question)
        case .answerCorrect:
            showCorrectResponse()
        case .answerInCorrect:
            showIncorrectResponse()
        }
        updateScore()
    }
    
    @IBAction func didTapOnSkip(_ sender: Any) {
        viewModel.skipQuestion()
    }
    
    @objc private func didTapOnAnswer1() {
        viewModel.answer(with: 0)
    }
    
    @objc private func didTapOnAnswer2() {
        viewModel.answer(with: 1)
    }
    
    @objc private func didTapOnAnswer3() {
        viewModel.answer(with: 2)
    }
    
    private func updateScore() {
        scoreLabel.text = viewModel.scoreString
        questionsProgressBar.progress = CGFloat(viewModel.gameProgress)
    }
    
    private func showQuestion(_ question: Question) {
        headlineImageView.loadImage(at: question.imageUrl, completion: {[weak self] image in
            DispatchQueue.main.async {
                self?.bgImage.image = image//?.blurred(radius: 0.001)
            }
        })
        sectionLabel.text = question.section.capitalized
        standFirstLabel.text = question.standFirst
        answer1Label.text = question.headline0
        answer2Label.text = question.headline1
        answer3Label.text = question.headline2
        
    }
    
    private func showLoading() {
        headlineImageView.image = nil
        bgImage.image = nil
        answer1Label.text = ""
        answer2Label.text = ""
        answer3Label.text = ""
        sectionLabel.text = ""
    }
    
    private func showEndOfGame() {
        
    }
    
    private func showErrorMessage(_ message: String) {
        
    }
    
    private func showCorrectResponse() {
        guard let question = viewModel.currentQuestion else {
            return
        }
        
        let data = ResponsePresenter(question: question, image: headlineImageView.image, totalScore: viewModel.totalScore, isAnswerCorrect: true)
        responseViewController.responseData = data
        present(responseViewController, animated: true, completion: nil)
    }
    
    private func showIncorrectResponse() {
        guard let question = viewModel.currentQuestion else {
            return
        }
        
        let data = ResponsePresenter(question: question, image: headlineImageView.image, totalScore: viewModel.totalScore, isAnswerCorrect: false)
        responseViewController.responseData = data
        
        present(responseViewController, animated: true, completion: nil)
    }
}

extension QuestionsViewController: ResponseViewControllerDelegate {
    func nextQuestion(viewController: ResponseViewController) {
        viewModel.nextQuestion()
    }
}
