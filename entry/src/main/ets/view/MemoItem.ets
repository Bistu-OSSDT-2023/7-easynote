@Component
export default struct MemoItem {
  private content: string;
  @State isComplete: boolean = false;

  build() {
    Row() {
      Text(this.content)
        .fontSize('24fp')
        .fontWeight(500)
        .opacity(this.isComplete ? 0.4 : 1)
        .padding({left:'40vp'})
        .decoration({ type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None })
    }
    .borderRadius(24)
    .backgroundColor('#FFFFFF')
    .width('100%')
    .height('64vp')
    .onClick(() => {
      this.isComplete = !this.isComplete;
    })
  }
}