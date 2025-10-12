import { CommonModel } from "./common_model";
import { HomeArticleBean } from "./home_article";

export interface NavigationWrap extends CommonModel<NavigationStage[]> {

}

export interface NavigationStage {
  cid?:number
  name?:string
  articles?:HomeArticleBean[]
}