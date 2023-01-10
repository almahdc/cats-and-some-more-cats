//
//  Bindable.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class Bindable<Value> {
    var value: Value {
        didSet {
            observers.forEach { $0.value(self.value) }
        }
    }

    private var observers = [ObjectIdentifier: (Value) -> Void]()

    init(value: Value) {
        self.value = value
    }

    func bind<T: AnyObject>(_ observer: T, closure: @escaping (T, Value) -> Void) {
        closure(observer, value)

        let uuid = ObjectIdentifier(observer)
        observers[uuid] = { [weak self, weak observer] newValue in
            guard let observer else {
                self?.observers[uuid] = nil
                return
            }

            closure(observer, newValue)
        }
    }
}
