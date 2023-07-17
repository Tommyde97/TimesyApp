//
//  ProfileViewModel.swift
//  Timesy
//
//  Created by Tomas D. De Andrade Gomes on 7/17/23.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
