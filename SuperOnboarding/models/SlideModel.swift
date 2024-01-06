//
//  SlideModel.swift
//  SuperOnboarding
//
//  Created by Anna Ershova on 02.01.2024.
//

import Foundation

struct SlideModel {
    var text: String
    var picture: String
    var subtext: String
    var num: Int
}

struct SlideData {
    static var models: [SlideModel] = [
        SlideModel(text: "Per sfruttare al massimo l'app, puoi condividerci la tua posizione?", picture: "image3", subtext: "POSIZIONE", num: 0),
        SlideModel(text: "Ogni tanto inviamo degli sconti esclusivi tramite notifiche push, ci stai?", picture: "image2", subtext: "PROMOZIONI", num: 1),
        SlideModel(text: "Ordina a domicilio senza limiti di distanza. Non èmagia, è Moovenda!", picture: "image1", subtext: "PRONTO?", num: 2),
    ]
}

@propertyWrapper
struct Slides {
    var wrappedValue: [SlideModel] {
        return SlideData.models
    }
}
