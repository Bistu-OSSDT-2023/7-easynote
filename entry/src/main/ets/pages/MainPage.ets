import AddNoteDialog from '../view/AddNoteDialog';
import NoteList from '../view/NoteList';
import NoteData from '../common/bean/NoteItemBean';
import DataModel from '../viewmodel/DataModel';
import { saveTask } from '../viewmodel/MainPageModel';
import MemoList from '../view/MemoList';


@Entry
@Component
struct MainPage {
  @State targetData: Array<NoteData> = DataModel.getData();
  @State totalNoteCount: number = 0;
  @State latestUpdateDate: string = '-';
  @Provide @Watch('onProgressChanged') overAllProgressChanged: boolean = false;

  @State fontColor: string = '#ff13ffff'
  @State selectedFontColor: string = '#fffc0606'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

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
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
            this.NoteBar()
        }.tabBar(this.TabBuilder(0, '笔记'))
        TabContent() {
          this.MemoBar()
        }.tabBar(this.TabBuilder(1, '便签'))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(56)
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width(360)
      .height('100%')
      .backgroundColor('#ffe9e3e3')
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
        .color('#ffd75454')
    }.width('100%')
  }

  @Builder NoteBar()
  {
    Column() {
      NoteList({
        targetData: $targetData,
        onAddClick: () => this.dialogController.open()
      })
        .height('90%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffe9e3e3')
    .justifyContent(FlexAlign.Start)
  }

    @Builder MemoBar()
    {
      MemoList()
    }
  }
