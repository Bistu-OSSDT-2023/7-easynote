@Entry
@Component
struct Index {
  @State input:Array<String> = []
  @State  note:string='';
  customDialogController:CustomDialogController=new CustomDialogController({
    builder:CustomDialogWidget({
      note:$note,
      input:$input
    })
  })
  build() {
    Stack() {
      Column({space : 20}){
        List({ space: 20, initialIndex: 0 }) {
          ForEach(this.input, (item) => {
            ListItem() {
              Text(item)
                .width('100%').height(100).fontSize(16)
                .textAlign(TextAlign.Center).borderRadius(10).backgroundColor(0xFFFFFF)
            }
          }, item => item)
        }.width('90%')
      }

      Button('+', { type: ButtonType.Circle, stateEffect: true })
      .width(60)
      .height(60)
        .fontSize(52)
      .position({x: '80%', y: 600})
      .shadow({radius: 10})
      .onClick(() => {
        this.customDialogController.open()
      })


    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })

  }
}

@Component
struct TitleComponent{

  build(){
    Column({space : 50}){
      Text('笔记')
        .fontSize(30)
        .fontWeight(FontWeight.Regular)
        .fontColor(Color.Black)
    }
    .height('5%')
  }
}

@CustomDialog
export default struct CustomDialogWidget {
  @Link note:String;
  @Link input:Array<String>;
  private controller:CustomDialogController;
  onClickOk: (value: string) => void;
  build(){
    Column(){
      Text('输入内容')
      TextArea().onChange((value: string) => {
        this.note = value
      })

      Row(){
        Button('确定')
          .onClick(()=>{
            this.input.push(this.note);
          this.controller.close()
          })
        Button('取消')
          .onClick(()=>{
            this.controller.close()
          })
      }
    }
  }
}

