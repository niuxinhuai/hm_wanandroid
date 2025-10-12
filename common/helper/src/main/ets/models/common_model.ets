export interface CommonModel<T> {
  data?:T
}

export enum LoadingStatus {
  loading,
  error,
  complete,
  empty,
  idle
}