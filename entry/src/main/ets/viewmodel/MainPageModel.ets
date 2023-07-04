import promptAction from '@ohos.promptAction';
import DataModel from './DataModel';
import NoteData from '../common/bean/NoteItemBean';

export function saveTask(taskName: string) {
  if (taskName === '') {
    promptAction.showToast({
      message:'输入内容为空！',
      duration: 3000,
      bottom: 64
    });
    return;
  }
  DataModel.addData(new NoteData(taskName));
  this.targetData = DataModel.getData();
  this.overAllProgressChanged = !this.overAllProgressChanged;
  this.dialogController.close();
}