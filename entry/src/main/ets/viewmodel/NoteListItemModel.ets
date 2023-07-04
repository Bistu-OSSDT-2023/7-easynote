import DataModel from '../viewmodel/DataModel';

export function changeProgress(progress: number) {
  this.latestProgress = progress;
  let result = DataModel.updateProgress(this.index, this.latestProgress, this.updateDate);
  if (result) {
    this.overAllProgressChanged = !this.overAllProgressChanged;
  }
  this.isExpanded = false;
}