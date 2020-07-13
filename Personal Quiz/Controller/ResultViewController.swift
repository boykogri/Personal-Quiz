//
//  ResultViewController.swift
//  Personal Quiz
//
//  Created by Григорий Бойко on 12/07/2020.
//  Copyright © 2020 Grigory Boyko. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    var answers: [Answer]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResults()
    }
    
    private func updateResults(){
        //Получаем массив с типми животных
        let animals = answers.map { $0.type }
        var frequencyOfAnimals: [AnimalType : Int] = [:]
        //Заполняем словарь с частотой животных в ответах
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        }
        //Сортируем в порядке убывания
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted {$0.value > $1.value}
        if let resultAnimal = sortedFrequencyOfAnimals.first?.key {
            updateUI(with: resultAnimal)
        }
           
        
    }
    private func updateUI(with animal: AnimalType){
        resultLabel.text = "Вы - \(animal.rawValue)"
        definitionLabel.text = animal.definition
    }


}
