//
//  AnimalType.swift
//  Personal Quiz
//
//  Created by Григорий Бойко on 11/07/2020.
//  Copyright © 2020 Grigory Boyko. All rights reserved.
//

enum AnimalType: String {
    case rabbit = "🐰"
    case cat = "🐈"
    case dog = "🐶"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь!"
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Ваша сила -  в мудрости. Медленный и вдумчивый выигрывает на дальних дистанциях."
        }
    }
}
