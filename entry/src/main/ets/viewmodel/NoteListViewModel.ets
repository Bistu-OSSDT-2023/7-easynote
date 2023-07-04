import DataModel from '../viewmodel/DataModel';

export function deleteSelected() {
  DataModel.deleteData(this.selectArray);
  this.targetData = DataModel.getData();
  this.overAllProgressChanged = !this.overAllProgressChanged;
  this.isEditMode = false;
}

export function selectAllOrCancel(selectStatus: boolean) {
  let newSelectArray = [];
  this.targetData.forEach(() => {
    newSelectArray.push(selectStatus);
  });
  this.selectArray = newSelectArray;
}

export function isSelectAll(): boolean {
  if (this.selectArray.length === 0) {
    return false;
  }
  let deSelectCount = this.selectArray.filter(selected => selected === false).length;
  if (deSelectCount === 0) {
    this.selectAll = true;
    return true;
  }
  this.selectAll = false;
  return false;
}

export function isSelectRows(): boolean {
  return this.selectArray.filter((selected) => selected === true).length !== 0;
}