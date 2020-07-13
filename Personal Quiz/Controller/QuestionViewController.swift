//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Григорий Бойко on 12/07/2020.
//  Copyright © 2020 Grigory Boyko. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var singleStackView: UIStackView!
    
    @IBOutlet var multipleStackView: UIStackView!
    
   
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
     @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    // MARK: - Private Proporties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChoosen: [Answer] = []
    private var currentAnswers: [Answer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    

    
    // MARK: - IB Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        //Получаем индекс нажатой кнопки
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        //Находим и добавляем выбранный ответ
        let currentAnswer = currentAnswers[currentIndex]
        answersChoosen.append(currentAnswer )
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (swith, answer) in zip(multipleSwitches, currentAnswers){
            //Если свитч включен, добавляем ответ
            if swith.isOn { answersChoosen.append(answer) }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = Int(round(rangedSlider.value*Float(currentAnswers.count-1)))
        answersChoosen.append(currentAnswers[index])
        nextQuestion()
    }
    // MARK: - Private Methods
    private func updateUI(){
        //Прячем все стек вью
        for stackView in [singleStackView, multipleStackView, rangedStackView]{
            stackView?.isHidden = true
        }
        //Получаем текущий вопрос
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.text
        
        currentAnswers = currentQuestion.answers
        //Прогресс по вопросам
        let totalProgress = Float(questionIndex)/Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        //Установка navigation title
        title = "Вопрос №\(questionIndex+1) из \(questions.count)"
        
        //Показываем stack view исходя из типа вопроса
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
    }
    /// Setup single stack view
    /// - Parameter answers: - array with answers
    ///
    /// Description of methods
    private func updateSingleStackView(using answers: [Answer]){
        singleStackView.isHidden = false
        for (button, answer) in zip(singleButtons, answers){
            button.setTitle(answer.text, for: .normal)
        }
    }
    /// Setup multiple stack view
    /// - Parameter answers: - array with answers
    ///
    /// Description of methods
    private func updateMultipleStackView(using answers: [Answer]){
        multipleStackView.isHidden = false
        for (label, answer) in zip(multipleLabels, currentAnswers){
            label.text = answer.text
        }
    }
    /// Setup ranged stack view
    /// - Parameter answers: - array with answers
    ///
    /// Description of methods
    private func updateRangedStackView(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
        
    }
    
    // MARK: - Navigation
    private func nextQuestion(){
        questionIndex += 1
        if questionIndex < questions.count{
            updateUI()
        }else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue" else {return}
        let dvc = segue.destination as! ResultViewController
        dvc.answers = answersChoosen
        
    }

}
