# Toast for iOS

## 概要
ToastみたいなものをSwiftで実装してみた。

## 使い方
ToastView.swiftがToastの実装になります。
このファイルをプロジェクトにコピーすれば、使用可能です。

### テキストのみ表示
テキストのみをToastとして表示する場合には、以下のように使用してください。

```swift
ToastView.showText("Some text")
```

`showText`メソッドは、第二パラメータで表示時間を指定できます。
表示時間は、`ToastDuration`で定義されています。
`ToastDuration.Short`を指定することで、3秒間表示されます。
`ToastDuration.Long`を指定することで、6秒間表示されます。

```swift
showText(text: String, duration: ToastDuration = .Short)
```

### 画像＋テキストの表示
画像とテキストをToastに表示する場合には、以下のようにして使用してください。

```swift
let anImage = UIImage(named: "Some image")
ToastView.showText("Some text.", image: anImage)
```

画像とテキストを表示する際に使用するメソッドは、以下のように定義されています。

```swift
showText(text: String, image: UIImage, imagePosition: ToastImagePosition = .Left, duration: ToastDuration = .Short)
```

画像の表示位置は、`ToastImagePosition`で定義しています。

* .Top
  * テキストの上側に表示します。
* .Bottom
  * テキストの下側に表示します。
* .Left
  * テキストの左側に表示します。
* .Right
  * テキストの右側に表示します。

Toastの表示時間の設定については、テキストのみ表示を参照してください。

## ライセンス
改変、再配布はご自由にどうぞ。
自分の勉強用に作成しているため、非保証です。
