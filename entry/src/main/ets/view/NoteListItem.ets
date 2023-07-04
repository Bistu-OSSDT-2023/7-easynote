import NoteData from '../common/bean/NoteItemBean';

@Component
export default struct NoteListItem {
  @State taskItem: NoteData=new NoteData('');
  @Link selectArr: Array<boolean>;
  @Prop isEditMode: boolean;
  @Link @Watch('onClickIndexChanged') clickIndex: number;
  @State isExpanded: boolean = false;
  @Consume overAllProgressChanged: boolean;
  @State sliderMode: number = -1;
  private index: number;

  customDialogCheckNote:CustomDialogController=new CustomDialogController({
    builder:CustomDialogCheck({
      note:$taskItem
    })
  })

  onClickIndexChanged() {
    if (this.clickIndex !== this.index) {
      this.isExpanded = false;
    }
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Column() {
        this.NoteItem()
        if (this.isExpanded) {
          Blank()
        }
      }
      .height('64vp')
      .width('100%')
      .borderRadius(24)
      .backgroundColor(this.selectArr[this.index] ? '#1A007DFF' : Color.White)
      .onClick(() => {
        this.customDialogCheckNote.open()
        if (this.sliderMode === 3) {
          this.sliderMode = -1;
          return;
        }
        if (!this.isEditMode) {
          this.clickIndex = this.index;
        }
      })

      if (this.isEditMode) {
        Row() {
          Checkbox()
            .select(this.selectArr[this.index])
            .selectedColor('#007DFF')
            .width(20)
            .margin({ right: '16vp' })
            .onChange((isCheck: boolean) => {
              this.selectArr[this.index] = isCheck;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
    }
    .width('100%')
  }

  @Builder NoteItem() {
    Row() {
      Text(this.taskItem.noteContent)
        .fontSize('24fp')
        .fontWeight(500)
        .fontColor(Color.Black)
        .width('75%')
        .textAlign(TextAlign.Start)
        .maxLines(1)
        .padding({top:'42px',left:'24px'})
      Blank()
    }
    .width('100%')
  }
}

@CustomDialog
struct CustomDialogCheck {
  @Link note:NoteData;
  @State noteCurrent:NoteData=new NoteData('');
  @State isEditMode: boolean = false;
  private controller:CustomDialogController;
  onClickOk: (value: string) => void;
  build(){
    Column({space : 12}){
      if(this.isEditMode){
        Text('编辑内容')
          .textAlign(TextAlign.Center)
          .fontSize('20fp')
          .fontWeight(700)
          .padding({top:'20px'})
      }
      else {
        Text('查看内容')
          .textAlign(TextAlign.Center)
          .fontSize('20fp')
          .fontWeight(700)
          .padding({top:'20px'})
      }
        Column(){
          if(this.isEditMode){
            TextArea({text:this.note.noteContent})
              .placeholderColor(Color.Grey)
              .placeholderFont({ size:'25fp'})
              .caretColor(Color.Blue)
              .backgroundColor('#0D182431')
              .width('100%')
              .height('100%')
              .fontSize('26fp')
              .fontColor('#182431')
              .onChange((value: string) => {
                this.note.noteContent=value
              })
          }
          else {
            Text('')
            Text(this.note.noteContent)
              .fontSize('26fp')
              .textAlign(TextAlign.Start)
              .width('90%')
          }
        }
        .backgroundColor('#F1F3F5')
        .width('90%')
        .height('85%')
        .borderRadius(20)
        Row(){
          if(this.isEditMode){
            Button('取消')
              .onClick(()=>{
                this.isEditMode=false
                this.note.noteContent=this.noteCurrent.noteContent
              })
              .fontSize('16fp')
              .height('32vp')
              .width('96vp')
              .backgroundColor(Color.White)
              .fontColor('#007DFF')
          }
          else {
            Button('退出')
              .onClick(()=>{
                this.controller.close()
              })
              .fontSize('16fp')
              .height('32vp')
              .width('96vp')
              .backgroundColor(Color.White)
              .fontColor('#007DFF')
          }

          if(this.isEditMode){
            Button('确定')
              .fontSize('16fp')
              .height('32vp')
              .width('96vp')
              .backgroundColor(Color.White)
              .fontColor('#007DFF')
              .onClick(()=>{
                this.isEditMode=false
              })
          }
          else {
            Button('编辑')
              .fontSize('16fp')
              .height('32vp')
              .width('96vp')
              .backgroundColor(Color.White)
              .fontColor('#007DFF')
              .onClick(()=>{
                this.isEditMode=true
                this.noteCurrent.noteContent=this.note.noteContent
              })
          }
        }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Start)
  }
}



