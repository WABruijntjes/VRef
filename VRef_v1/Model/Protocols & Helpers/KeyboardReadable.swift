//
//  KeyboardReadable.swift
//  VRef_v1
//
//  Created by William on 22/12/2022.
//

import Foundation
import Combine
import UIKit

protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}
