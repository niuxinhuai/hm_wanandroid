import { CommonModel } from "./common_model"

export interface HotSearchWrap extends CommonModel<HotSearchItem[]> {}

export interface HotSearchItem {
  id?:number
  link?:string
  name?:string
  order?:number
  visible?:number
}