# cats-and-some-more-cats

## Simple app that shows cat memes for specific http status codes

# Details:
- Swift + UIKit
- MVVM + Clean Architecture (at least this was the desired outcome)
- Business logic is unit-tested
- No frameworks other than UIKit and Foundation were used
- The app is suitable for usage on iPhone and iPad

# Features:
- Screen with a list of status codes
- Tap on section with status code opens a new screen with a cat meme
- After section was tapped: 
    - it gets sorted on top of the list
    - right positioned label gets a different text indicating it was tapped
- Screen with a cat meme has a title, loading indicator, image, and try again button to cover states of image: loading, success, and failure
