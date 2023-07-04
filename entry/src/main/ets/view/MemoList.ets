import ToDoItem from '../view/MemoItem';
import MemoDataModel from '../viewmodel/MemoData';
import AddMemoDialog from './AddMemoDialog';

@Component
export default struct MemoList{

  @State totalTasks: Array<string> = [];

  customDialogAddMemo:CustomDialogController=new CustomDialogController({
    builder:AddMemoDialog({
        totalTasks:$totalTasks
    })
  })


  aboutToAppear() {
    this.totalTasks = MemoDataModel.getData();
  }

  build(){
    Column({space:12}) {
      Row(){
        Text('待办')
          .fontSize('20fp')
          .fontWeight(700)
          .fontColor('#182431')
      }
      .width('100%')
      .height('25vp')

      ForEach(this.totalTasks, (item) => {
        ToDoItem({ content: item })
      }, item => JSON.stringify(item))
      Blank()
      Button('添加待办')
        .operateButtonStyle('#007DFF')
        .onClick(() => {
          this.customDialogAddMemo.open()
        })
    }
    .width('93.3%')
    .height('90%')
    .padding({ top: '16vp' })
  }

}

@Extend(Button) function operateButtonStyle(color: string) {
  .width('156vp')
  .height('40vp')
  .fontSize('16fp')
  .fontWeight(500)
  .fontColor(color)
  .backgroundColor('#0D182431')
}