export interface CommonModel<T> {
  data?:T
  errorCode?:number
  errorMsg?:string
}

export enum LoadingStatus {
  loading,
  error,
  complete,
  empty,
  idle
}