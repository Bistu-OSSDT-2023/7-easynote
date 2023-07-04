import NoteData from '../common/bean/NoteItemBean';
import NoteListItem from './NoteListItem';
import { selectAllOrCancel, deleteSelected, isSelectAll, isSelectRows } from '../viewmodel/NoteListViewModel';

@Component
export default struct NoteList {
  @Consume overAllProgressChanged: boolean;
  @State isEditMode: boolean = false;
  @State selectArray: Array<boolean> = [];
  @State clickIndex: number = -1;
  @State selectAll: boolean = false;
  @Link targetData: Array<NoteData>;
  onAddClick: () => void;

  build() {
    Column() {
      Row() {
        Text("笔记集")
          .fontSize('20fp')
          .fontWeight(700)
          .fontColor('#182431')
        Blank()
        if (this.targetData.length > 0) {
          if (this.isEditMode) {
            Text('取消')
              .operateTextStyle('#007DFF')
              .margin({ left: '16vp' })
              .onClick(() => {
                this.selectAll = false;
                this.isEditMode = false;
                selectAllOrCancel.call(this, false);
              })
            Text('全选')
              .operateTextStyle('#007DFF')
              .margin({
                left: '16vp'
              })
            Checkbox()
              .select(isSelectAll.call(this))
              .selectedColor('#007DFF')
              .width(20)
              .onClick(() => {
                this.selectAll = !this.selectAll;
                selectAllOrCancel.call(this, this.selectAll);
              })
          } else {
            Text('编辑')
              .operateTextStyle('#007DFF')
              .fontSize('18fp')
              .onClick(() => {
                this.isEditMode = true;
                selectAllOrCancel.call(this, false);
              })
          }
        }
      }
      .width('100%')
      .height('30vp')
      .padding({
        left: '16vp',
        right: '11vp'
      })

      List({ space: 30 }) {
        ForEach(this.targetData, (item: NoteData, index: number) => {
          ListItem() {
            NoteListItem({
              taskItem: item,
              index: index,
              selectArr: $selectArray,
              isEditMode: this.isEditMode,
              clickIndex: $clickIndex
            })
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
      .edgeEffect(EdgeEffect.None)
      .margin({ top: '12vp'})
      .width('100%')
      .height('80%')

      Blank()
      if (this.isEditMode) {
        Button('删除')
          .opacity(isSelectRows.call(this) ? 1 : 0.4)
          .enabled(isSelectRows.call(this) ? true : false)
          .operateButtonStyle('#E84026')
          .onClick(() => {
            deleteSelected.call(this);
            selectAllOrCancel.call(this, false);
            this.selectAll = false;
          })
      } else {
        Button('添加笔记')
          .operateButtonStyle('#007DFF')
          .onClick(() => this.onAddClick())
      }
    }
    .width('93.3%')
    .height('105%')
    .padding({ top: '16vp' })
  }
}

@Extend(Text) function operateTextStyle(color: string) {
  .fontSize('16fp')
  .fontColor(color)
  .lineHeight('19vp')
  .fontWeight(500)
}

@Extend(Button) function operateButtonStyle(color: string) {
  .width('156vp')
  .height('40vp')
  .fontSize('16fp')
  .fontWeight(500)
  .fontColor(color)
  .backgroundColor('#0D182431')
}