import DataModel from  '../viewmodel/MemoData';

@CustomDialog
export default struct AddMemoDialog{
  @State subNoteContent: string = '';
  private controller: CustomDialogController;
  @Link totalTasks: Array<string>;

  build(){
    Column(){
      Text("添加便签")
      TextInput({ placeholder: '请输入内容'})
        .onChange((value: string) => {
          this.subNoteContent = value;
        })
      Row(){
        Button('取消')
          .dialogButtonStyle()
          .onClick(() => {
            this.controller.close();
          })
        Button('确定')
          .dialogButtonStyle()
          .onClick(() => {
            this.totalTasks.push(this.subNoteContent)
            this.controller.close()
          })
      }
    }

  }
}

@Extend(Button) function dialogButtonStyle() {
  .fontSize('16fp')
  .height('40vp')
  .width('96vp')
  .backgroundColor(Color.White)
  .fontColor('#007DFF')
}