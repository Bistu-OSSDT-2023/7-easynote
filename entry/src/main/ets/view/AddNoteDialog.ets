@CustomDialog
export default struct AddNoteDialog {
  @State subNoteContent: string = '';
  private controller: CustomDialogController;
  onClickOk: (value: string) => void;

  build() {
    Column() {
      Text('添加笔记')
        .width('100%')
        .fontSize('20fp')
        .fontWeight(500)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
      TextArea({ placeholder: '请输入内容'})
        .placeholderColor(Color.Grey)
        .placeholderFont({ size:'25fp'})
        .caretColor(Color.Blue)
        .backgroundColor('#0D182431')
        .width('100%')
        .height('90%')
        .margin({top: '6%'})
        .fontSize('25fp')
        .fontColor('#182431')
        .onChange((value: string) => {
          this.subNoteContent = value;
        })
      Blank()
      Row() {
        Button('取消')
          .dialogButtonStyle()
          .onClick(() => {
            this.controller.close();
          })
        Button('确定')
          .dialogButtonStyle()
          .onClick(() => {
            this.onClickOk(this.subNoteContent);
          })
      }
      .width('70%')
      .height('8%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding('24vp')
    .height('90%')
    .width('90.3%')
    .borderRadius(32)
    .backgroundColor(Color.White)
  }
}

@Extend(Button) function dialogButtonStyle() {
  .fontSize('16fp')
  .height('32vp')
  .width('96vp')
  .backgroundColor(Color.White)
  .fontColor('#007DFF')
}