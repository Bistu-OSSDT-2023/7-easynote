import AddNoteDialog from '../view/AddNoteDialog';
import NoteList from '../view/NoteList';
import NoteData from '../common/bean/NoteItemBean';
import DataModel from '../viewmodel/DataModel';
import { saveTask } from '../viewmodel/MainPageModel';


@Entry
@Component
struct MainPage {
  @State targetData: Array<NoteData> = DataModel.getData();
  @State totalNoteCount: number = 0;
  @State latestUpdateDate: string = '-';
  @Provide @Watch('onProgressChanged') overAllProgressChanged: boolean = false;

  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddNoteDialog({
      onClickOk: saveTask.bind(this)
    }),
    alignment: DialogAlignment.Top,
    offset: {
      dx: 0,
      dy:'16vp'
    },
    customStyle: true,
    autoCancel: false
  });

  onProgressChanged() {
    this.totalNoteCount = this.targetData.length;
  }

  build() {
    Column() {
      this.NoteBar()
    }.width('100%')
  }

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 800 : 400)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
    }.width('100%')
  }

  @Builder NoteBar()
  {
    Column() {
      Text('笔记')
        .fontSize('20fp')
        .fontWeight(700)
        .fontColor('#182431')
        .padding({top:'12vp'})
      NoteList({
        targetData: $targetData,
        onAddClick: () => this.dialogController.open()
      })
        .height('90%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
  }
  }
