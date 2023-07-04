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
      this.titleBar()
      Divider().vertical(false).strokeWidth(5).color(0x2788D9).lineCap(LineCapStyle.Round)
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

  @Builder
  titleBar() {
    Text('笔记')
      .width('86.7%')
      .height('32vp')
      .fontSize('24fp')
      .fontWeight(700)
      .textAlign(TextAlign.Start)
      .margin({
        top:'12vp',
        bottom:'12vp'
      })
  }
}