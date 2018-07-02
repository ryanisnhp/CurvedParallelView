# **Curved Parallel View**
Simple example use **UIBezierPath** and **CALayer**
# **Screenshot**
![screenshot](https://github.com/ryanisnhp/CurvedParallelView/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-07-02%20at%2014.35.17_framed.png?raw=true)

# **How to set up?**
**Create view by this way**
```swift
viewFrame = CGRect(x: coorX, y: coory, width: width, height: height)
curvedParallelView = ThumbView(frame: viewFrame)
curvedParallelView.backgroundColor = .clear
curvedParallelView.delegate = self
self.addSubview(curvedParallelView)
```

Then you can create theme **ParallelTheme**
```swift
init(fillBackgroundColor: UIColor?, curved: CGFloat?, imageBackground: UIImage?, miniViewWidthPortition: CGFloat?, miniViewHeight: CGFloat?, miniViewContent: String?, miniViewBackgroundColor: UIColor?, miniViewContentColor: UIColor?)
```

```swift 
fillBackgroundColor: UIColor? //view's background
curved: CGFloat? //corner radius on the main view, this curved will use to set corner radius on the mini view inside
imageBackground: UIImage? //background image
miniViewWidthPortition: CGFloat? // portition between mini view and main view
miniViewHeight: CGFloat? // height for mini view
miniViewContent: String? //content for label on mini view
miniViewBackgroundColor: UIColor? //background for mini view
miniViewContentColor: UIColor? // text color for label on mini view
```

**and use theme by this way**
```swift
curvedParallelView.dropTheme(theme: theme)
```
**there is an info button on the view, use delegate if you want to hanlde events on that button**
```swift
curvedParallelView.delegate = self
```
```swift
extension ListCurvedParallelViewController: OnTapButtonDelegate{
    func onTapButton(cell: CurvedParallelCell) {
        debugPrint("Tap info on cell")
    }
}
```

## Features

- [x] Curved Parallel View with simple case 💪
- [x] Dynamic label width and mini view 🚴
- [ ] Minimize Label font size when it's too long 🤸
- [ ] Validate valid constraints 🎬
- [ ] Allow user customize it as much as possible 🎁
- [ ] Create more awesome UI 😍
