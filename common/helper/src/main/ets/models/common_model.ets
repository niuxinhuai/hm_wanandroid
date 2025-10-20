export interface CommonModel<T> {
  data?:T
  errorCode?:number
  errorMsg?:string
}

export interface SimpleModel extends CommonModel<ESObject> {}

export enum LoadingStatus {
  loading,
  error,
  complete,
  empty,
  idle
}