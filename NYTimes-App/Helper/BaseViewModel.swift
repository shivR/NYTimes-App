//
//  BaseViewModel.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

protocol BaseViewModel {
    var showIndicator: (Bool) -> Void { get set }
    var reloadView: () -> Void { get set }
    var showError: (String) -> Void { get set }
}
