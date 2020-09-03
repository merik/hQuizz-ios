//
//  ResponseViewController.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

protocol ResponseViewControllerDelegate: class {
    func nextQuestion(viewController: ResponseViewController)
}

class ResponseViewController: UIViewController {

    private let colorForCorrectAnswer = UIColor(hQuizz: .primary)
    private let colorForIncorrectAnswer = UIColor(hQuizz: .danger)
    
    @IBOutlet weak var bgImage: hQuizzBgImage!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var standFirstLabel: UILabel!
    @IBOutlet weak var totalPointsLine1Label: UILabel!
    @IBOutlet weak var totalPointsLine2Label: UILabel!
    @IBOutlet weak var totalPointsLine3Label: UILabel!
    @IBOutlet weak var totalPointsView: hQuizzCircularView!
    
    weak var delegate: ResponseViewControllerDelegate?
    
    var responseData: ResponsePresenter?
    
    @IBAction func didTapOnNextQuestion(_ sender: Any) {
        delegate?.nextQuestion(viewController: self)
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }
    
    private func showData() {
        guard let data = responseData else {
            return
        }
        
        totalPointsView.color = data.isAnswerCorrect ? colorForCorrectAnswer : colorForIncorrectAnswer
        
        totalPointsLine1Label.text = data.isAnswerCorrect ? "That's Right".uppercased() : "OOPS!"
        
        bgImage.image = data.image
        questionImageView.image = data.image
        headlineLabel.text = data.question.correctHeadline
        standFirstLabel.text = data.question.standFirst
        showTotalPoints(data.totalScore)
        
    }
    
    private func showTotalPoints(_ points: Int) {
        let numberAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .black), NSAttributedString.Key.foregroundColor : UIColor.white]
        let textAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let numberString = NSMutableAttributedString(string: "\(points)", attributes: numberAttrs)
        let textString = NSMutableAttributedString(string: " Points".uppercased(), attributes: textAttrs)
        
        numberString.append(textString)
        totalPointsLine3Label.attributedText = numberString
    }
   
   
}
