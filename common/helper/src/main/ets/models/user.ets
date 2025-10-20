import { AxiosResponse } from "@ohos/axios"
import { ArrayUtil, DateUtil, JSONUtil, StrUtil, ToastUtil } from "@pura/harmony-utils"
import { CommonServices, SpUtil } from "../../../../Index"
import ServiceHelper from "../service_helper/service_helper"
import { SimpleModel } from "./common_model"
import { HomeArticleBean } from "./home_article"
import { LoginWrap } from "./login"

export enum LoginState {
  normal,
  login,
  notLogin
}

@ObservedV2
export class DefaultUser {
  private static instance?: DefaultUser

  public static getInstance(): DefaultUser {
    if (!DefaultUser.instance) {
      DefaultUser.instance = new DefaultUser()
    }
    return DefaultUser.instance
  }

  @Trace username?: string
  @Trace password?: string
  @Trace cookie?: string
  @Trace cookieExpiresDateTime?: Date
  @Trace loginState: LoginState = LoginState.normal
  @Trace collect_list: string[] = []

  async onCreate() {
    this.username = await SpUtil.getUserName()
    this.password = await SpUtil.getPassword()
    this.cookie = await SpUtil.getCookie()
    const dateStr = await SpUtil.getCookieExpires()
    await this.saveFavorite()
    const collectStr = await SpUtil.getCollectListStr()
    if (StrUtil.isNotEmpty(collectStr)) {
      this.collect_list = collectStr.split(',')
    }
    console.log(`>>>>>username:${this.username} >>>>>>cookie:${this.cookie} >>>>dateStr:${dateStr} >>collect_list:${this.collect_list}`)
    if (StrUtil.isNotEmpty(dateStr)) {
      this.cookieExpiresDateTime = new Date(dateStr)
      const date = DateUtil.getAmountDay(new Date(), 3)
      const diff = DateUtil.compareDate(this.cookieExpiresDateTime, date)
      if (diff > 0) {
        //提前更新数据
        this.autoLogin()
      } else {
        this.loginState = LoginState.login
      }
      console.log(">>>>>>>>>>diff" + diff)
    } else {
      this.loginState = LoginState.notLogin
    }
  }

  isLogin(): boolean {
    return StrUtil.isNotEmpty(this.username) && StrUtil.isNotEmpty(this.password)
  }

  private autoLogin() {
    if (this.isLogin()) {
      this.login(this.username!, this.password!)
    }
  }

  async login(name: string, psw: string): Promise<LoginWrap> {
    const value: AxiosResponse = await CommonServices.login(name, psw)
    const wrap = value.data as LoginWrap
    if (wrap.errorCode == 0) {
      const cookie = JSONUtil.beanToJsonStr(value.headers["set-cookie"]).replaceAll("\[\"", "")
        .replaceAll("\"\]", "")
        .replaceAll("\",\"", "; ")
      SpUtil.setUserName(name)
      SpUtil.setPassword(psw)
      SpUtil.setCookie(cookie)
      await this.saveFavorite()
      const obj = RegExp("Expires[^;]*;").exec(cookie)
      console.log('>>>>>>>>>obj:' + obj?.length)
      if ((obj?.length ?? 0) > 0) {
        const dateStr = obj?.[0] ?? ''
        SpUtil.setCookieExpires(`${dateStr}`)
      }
      await DefaultUser.getInstance().onCreate()
    }
    return wrap
  }

  private async saveFavorite() {
    const e = await CommonServices.getCollectList(0, 40)
    if (!ArrayUtil.isEmpty(e.data?.datas)) {
      const list = e.data!.datas!.map((e) => `${e.title ?? ''}`)
      SpUtil.setCollectList(list)
    }
  }

  async userTapFavorite(data: HomeArticleBean, fromCollect: boolean = false) {
    const wrap = await this.collect(data, fromCollect)
    if (wrap.errorCode == 0) {
      if (!this.includeArticleId(data,fromCollect)) {
        ToastUtil.showToast('收藏成功')
        this.collect_list.push(`${data.title}`)
      } else {
        this.collect_list = this.collect_list.filter((e) => e == `${data.title ?? ''}`)
        ToastUtil.showToast('取消收藏成功')
      }
      SpUtil.setCollectList(this.collect_list)
    } else {
      ToastUtil.showToast(wrap.errorMsg ?? '失败了～')
    }
  }

  public includeArticleId(data: HomeArticleBean, fromCollect: boolean = false): boolean {
    const id = fromCollect ? data.origin : data.id
    if (this.collect_list.includes(`${data.title ?? ''}`)) {
      return true
    }
    return false
  }

  private async collect(data: HomeArticleBean, fromCollect: boolean = false): Promise<SimpleModel> {
    console.log('>>>>>>>>>>>>>data' + JSONUtil.beanToJsonStr(data))
    const id = fromCollect ? data.origin : data.id
    if (!this.includeArticleId(data,fromCollect)) {
      if (StrUtil.isNotEmpty(data.link) && data.link?.includes('wanandroid.com')) {
        return await CommonServices.collectInArticle(id ?? '')
      }
      const title = data.title
      let author = data.author
      if (StrUtil.isEmpty(author)) {
        author = data.shareUser
      }
      const link = data.link
      if (StrUtil.isNotEmpty(title) && StrUtil.isNotEmpty(author) && StrUtil.isNotEmpty(link)) {
        return await CommonServices.collectOutArticle(title, author, link)
      }
    }
    if (this.includeArticleId(data,fromCollect)) {
      if (!fromCollect) {
        return { errorCode: -1, errorMsg: '取消收藏请到收藏页' } as SimpleModel
      }
      return await CommonServices.unCollectArticle(id ?? '')
    }

    return { errorCode: -1, errorMsg: '数据出错' } as SimpleModel
  }
}