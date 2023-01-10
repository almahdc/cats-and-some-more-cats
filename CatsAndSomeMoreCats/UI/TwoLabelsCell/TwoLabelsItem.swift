//
//  TwoLabelsItem.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import Foundation

struct TwoLabelsItem {
    let leftTitle: String
    let wasTapped: DisposableBindable<Bool>
    let rightTitleInitially: String = "Tap to see a cat 🐈‍⬛"
    let rightTitleWhenTapped: String = "🔥 Yay, you saw a cat."
}

extension TwoLabelsCell {
    func apply(_ item: TwoLabelsItem) {
        leftLabel.text = item.leftTitle
        rightLabel.text = rightLabelText(item: item)
        item.wasTapped.bind(self) { observer, wasTapped in
            observer.rightLabel.text = observer.rightLabelText(item: item)
        }
    }

    private func rightLabelText(item: TwoLabelsItem) -> String {
        item.wasTapped.value ? item.rightTitleWhenTapped : item.rightTitleInitially
    }
}
