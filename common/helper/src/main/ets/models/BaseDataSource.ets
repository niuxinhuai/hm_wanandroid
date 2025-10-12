@ObservedV2
class BasicDataSource<T> implements IDataSource {
  @Trace listeners: DataChangeListener[] = [];
  @Trace originDataArray: T[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): T {
    return this.originDataArray[index];
  }

  // 系统调用，开发不用关心
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 系统调用，开发不用关心
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件，这个有可能闪烁
  // 用 onDatasetChange 代替onDataReloaded，不仅可以修复闪屏的问题，还能提升加载性能
  // https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-rendering-control-lazyforeach-V5
  // 通知组件重新加载所有数据。键值没有变化的数据项会使用原先的子组件，键值发生变化的会重建子组件。重新加载数据完成后调用。
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange([{ type: DataOperationType.RELOAD }]);
    })
  }

  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }
}

@ObservedV2
export class BaseDataSource<T> extends BasicDataSource<T> {
  @Trace dataArray: T[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  /**
   * 获取数据
   * @param index
   * @returns
   */
  public getData(index: number): T {
    return this.dataArray[index];
  }

  public clear() {
    this.dataArray = []
  }

  /**
   * 删除 index 下的数组，如果 index 大于或者等于 ，则不删除，也不添加
   * @param index
   * @returns 是否成功
   */
  public deleteData(index: number): boolean {
    if (this.dataArray.length > index) {
      this.dataArray.splice(index, 1);
      this.notifyDatasetChange([
        { type: DataOperationType.DELETE, index: index }
      ])
      return true;
    }
    console.warn(`deleteData 当前的index=${index} 已经大于或者等于 数组的length=${this.dataArray.length}`)
    return false;
  }

  /**
   * 移动数据，如果 from to 大于或者等于 则不移动
   * @param from 要移动的index
   * @param to 要移动到的目标index
   * @returns 是否成功
   */
  public moveData(from: number, to: number): boolean {
    if (this.dataArray.length > from && this.dataArray.length > to) {
      this.notifyDatasetChange([
        { type: DataOperationType.MOVE, index: { from: from, to: to } }
      ])
      return true
    }
    console.warn(`moveData 当前的from=${from} to=${to} 已经大于或者等于 数组的length=${this.dataArray.length}`)
    return false
  }

  /**
   * 向数组末尾添加一个元素
   * @param arr 要添加元素的数组
   * @param element 要添加的元素
   * @returns 返回添加元素后的数组
   */
  public addData(data: T, index?: number): void {
    if (index) {
      this.addIndexData(index, data);
    } else {
      this.dataArray.push(data);
      this.notifyDatasetChange([
        { type: DataOperationType.ADD, index: this.dataArray.length - 1 }])
    }
  }

  /**
   * 通知单个item更改
   * 如果是新的数据，那么相当于重新设置了数据，如果里面有图片 ，图片会闪一下
   * 可以使用 @Observed 和 @ObjectLink 配合使用去更新数据，避免闪烁
   * @param index
   * @param data
   * @returns 是否成功
   */
  public notifyItemChange(index: number, data: T): boolean {
    // 是否需要这样，这个的本意就是通知当前item改变了
    if (this.dataArray.length > index) {
      // 但是如果没有这个index ，这里会增加
      this.dataArray.splice(index, 1, data);
      this.notifyDatasetChange([
        { type: DataOperationType.CHANGE, index: index }])
      return true;
    }
    console.warn(`notifyItemChange 当前的index=${index} 已经大于或者等于 数组的length=${this.dataArray.length}`)
    return false;
  }

  /**
   * 在末尾添加一个数组
   * @param data
   */
  public addAllData(data: Array<T>): void {
    const totalCount = this.dataArray.length;
    this.dataArray.push(...data);
    this.notifyDatasetChange([
      { type: DataOperationType.ADD, index: totalCount, count: data.length }])
  }

  /**
   * 添加全新的数据，也就是清空原有的数据，添加新的数组
   * @param data
   */
  public setNewData(data: Array<T>) {
    let oldLength = this.dataArray.length
    this.dataArray.splice(0, this.dataArray.length);
    this.dataArray.push(...data)
    this.notifyDatasetChange([
      { type: DataOperationType.DELETE, index: 0, count: oldLength },
      { type: DataOperationType.ADD, index: 0, count: data.length },
      // 这样可以服用以前的数据，比如 setNewData 两次同样的数据，如果不加这个会闪烁
      { type: DataOperationType.RELOAD },

    ])
  }

  private addIndexData(index: number, data: T): void {
    if (this.dataArray.length >= index) {
      this.dataArray.splice(index, 0, data);
      this.notifyDatasetChange([
        { type: DataOperationType.ADD, index: index }])
    } else {
      console.warn(`addData 当前的index=${index} 已经大于 数组的length=${this.dataArray.length}`)
    }
  }
}
