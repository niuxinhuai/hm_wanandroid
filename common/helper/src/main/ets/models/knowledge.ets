import { CommonModel } from "./common_model"

export interface KnowledgeWrap extends CommonModel<KnowledgeStage[]>{}

export interface KnowledgeStage {

  visible?:number
  userControlSetTop?:boolean
  parentChapterId?:number
  order?:number
  name?:string
  lisenseLink?:string
  lisense?:string
  id?:number
  desc?:string
  cover?:string
  courseId?:number
  author?:string
  children?: KnowledgeChild[]
}

export interface KnowledgeChild {

  visible?:number
  userControlSetTop?:boolean
  parentChapterId?:number
  order?:number
  name?:string
  lisenseLink?:string
  lisense?:string
  id?:number
  desc?:string
  cover?:string
  courseId?:number
  author?:string
}