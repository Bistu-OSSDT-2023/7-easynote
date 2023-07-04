import Logger from '../common/utils/Logger';
import NoteData from '../common/bean/NoteItemBean';

const TAG = '[DataModel]';

export class DataModel {

  private targetData: Array<NoteData> = [];

  getData(): Array<NoteData> {
    return this.targetData;
  }

  deleteData(selectArr: Array<boolean>) {
    if (!selectArr) {
      Logger.error(TAG, 'Failed to delete data because selectArr is ' + selectArr);
    }
    let dataLen = this.targetData.length - 1;
    for (let i = dataLen; i >= 0; i--) {
      if (selectArr[i]) {
        this.targetData.splice(i, 1);
      }
    }
  }

  addData(data: NoteData) {
    if (!data) {
      Logger.error(TAG, 'addData error because data is: ' + data);
      return;
    }
    this.targetData.push(data);
  }

  getLatestProgressValue(): number {
    if (this.targetData.length === 0) {
      return 0;
    }
  }

  updateProgress(index: number, updateValue: number, updateDate: string): boolean {
    if (!this.targetData[index]) {
      return false;
    }
    return true;
  }
}

export default new DataModel();