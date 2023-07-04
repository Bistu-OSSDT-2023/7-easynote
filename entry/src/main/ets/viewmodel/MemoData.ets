export class DataModel {

  private tasks: Array<string> ;

  getData(): Array<string> {
    return this.tasks;
  }
  addData(data: string) {

    this.tasks.push(data);
  }

}

export default new DataModel();