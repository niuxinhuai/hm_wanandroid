import { ZRouter } from "@hzw/zrouter";
import { RouterConstants } from "../../../../Index";

export interface RouterQuery {
  link?: string,
  title?: string,
  arg?:object
  index?:number
  keyword?:string
}

export class RouterUtils {
  public static async push(name: string,args?: RouterQuery) {
    ZRouter.getInstance().setParam(args).navigation(name)
  }

  public static async pushWeb(param:string) {
    RouterUtils.push(RouterConstants.web,{"link":param})
  }

  /**
   * 页面返回聚合方法
   * @param opts
   */
  public static pop(name?: string, result?: Object, animated: boolean = true, toRoot: boolean = false) {
    ZRouter.getInstance()
      .navigateBack({
        animated: animated,
        toRoot: toRoot,
        name: name,
        result: result
      })
  }
}