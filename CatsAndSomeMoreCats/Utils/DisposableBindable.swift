//
//  DisposableBindable.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 10.01.23.
//

import UIKit

final class DisposableBindable<Value> {
    var value: Value {
        didSet {
            observers.forEach { $0.value(self.value) }
        }
    }

    private var observers = [ObjectIdentifier: (Value) -> Void]()

    init(value: Value) {
        self.value = value
    }
    
    func bind<T: DisposableObserverable>(_ observer: T, closure: @escaping (T, Value) -> Void) {
        closure(observer, value)

        let uuid = ObjectIdentifier(observer)
        observer.add { [weak self] in
            self?.observers[uuid] = nil
        }
        observers[uuid] = { [weak self, weak observer] newValue in
            guard let observer else {
                self?.observers[uuid] = nil
                return
            }

            closure(observer, newValue)
        }
    }
}

protocol DisposableObserverable: AnyObject {
    func add(disposeBlock: @escaping Action)
}

class DisposableObserverableCell: UITableViewCell {
    private var disposeObservers = [Action]()

    override open func prepareForReuse() {
        super.prepareForReuse()
        disposeObservers.forEach { $0() }
        disposeObservers = []
    }
}

extension DisposableObserverableCell: DisposableObserverable {
    func add(disposeBlock: @escaping Action) {
        disposeObservers.append(disposeBlock)
    }
}

