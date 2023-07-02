@Entry
@Component
struct Index {
  @State input:Array<string> = []
  @State  note:string='';
  n:Number
  customDialogController:CustomDialogController=new CustomDialogController({
    builder:CustomDialogWidget({
      note:$note,
      input:$input
    })
  })

  customDialogCheckNote:CustomDialogController=new CustomDialogController({
    builder:CustomDialogCheck({
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
                .width('100%').height(92).fontSize(25)
                .textAlign(TextAlign.Start).borderRadius(10).backgroundColor(0xFFFFFF)
                .onClick(() => {
                  this.customDialogCheckNote.open()
                })
                .onTouch((event:TouchEvent)=>{
                  if (event.type === TouchType.Move) {
                    this.input.pop()
                  }
                })
            }
          }, item => item)
        }.width('90%')
      }.justifyContent(FlexAlign.Start).width('100%')

      Button('+', { type: ButtonType.Circle, stateEffect: true })
      .width(60)
      .height(60)
        .fontSize(52)
      .position({x: '70%', y: 650})
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
    Column(){
      Text('笔记')
        .fontSize(30)
        .fontWeight(FontWeight.Regular)
        .fontColor(Color.Black)
    }
    .height('5%').backgroundColor(Color.Blue)
  }
}

@CustomDialog
export default struct CustomDialogWidget {
  @Link note:String;
  @Link input:Array<String>;
  private controller:CustomDialogController;
  onClickOk: (value: string) => void;
  build(){
    Column({space : 10}){
      Text('输入内容').fontSize(30).height('80')
      TextArea().onChange((value: string) => {
        this.note = value
      }).height('450').width('90%')

      Row({space : 100}){
        Button('确定')
          .onClick(()=>{
            if(this.note!=''){
              this.input.push(this.note);
            }
          this.controller.close()
          })
        Button('取消')
          .onClick(()=>{
            this.controller.close()
          })
      }
    }.height('98%')
  }
}

@CustomDialog
struct CustomDialogCheck {
  @Link note:string;
  @Link input:Array<string>;
  private controller:CustomDialogController;
  onClickOk: (value: string) => void;
  build(){
    Column({space : 10}){
      Text('查看内容').fontSize(30).height('80')
      Text(this.input[0])
        .width('100%').height(92).fontSize(25)
        .textAlign(TextAlign.Start).borderRadius(10).backgroundColor(0xFFFFFF)

      Row({space : 100}){
        Button('退出')
          .onClick(()=>{
            this.controller.close()
          })
      }
    }.height('98%')
  }
}