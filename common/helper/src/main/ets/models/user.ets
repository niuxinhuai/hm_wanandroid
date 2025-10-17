import { AxiosResponse } from "@ohos/axios"
import { DateUtil, JSONUtil, StrUtil } from "@pura/harmony-utils"
import { CommonServices, SpUtil } from "../../../../Index"
import { LoginWrap } from "./login"

@ObservedV2
export class DefaultUser {
  private static instance?: DefaultUser

  public static getInstance():DefaultUser {
    if (!DefaultUser.instance) {
      DefaultUser.instance = new DefaultUser()
    }
    return DefaultUser.instance
  }

  @Trace username?:string
  @Trace password?:string
  @Trace cookie?:string
  @Trace cookieExpiresDateTime?:Date

   async onCreate() {
    this.username = await SpUtil.getUserName()
    this.password = await SpUtil.getPassword()
    this.cookie = await SpUtil.getCookie()
    const dateStr = await SpUtil.getCookieExpires()
     console.log(`>>>>>username:${this.username} >>>>>>cookie:${this.cookie} >>>>dateStr:${dateStr}`)
    if (StrUtil.isNotEmpty(dateStr)) {
      this.cookieExpiresDateTime = new Date(dateStr)
      const date = DateUtil.getAmountDay(new Date(), 3)
      const diff = DateUtil.compareDate(this.cookieExpiresDateTime,date)
      if (diff > 0) {
        //提前更新数据
        this.autoLogin()
      }
      console.log(">>>>>>>>>>diff" + diff)
    }
  }

  isLogin():boolean {
    return StrUtil.isNotEmpty(this.username) && StrUtil.isNotEmpty(this.password)
  }

  private autoLogin() {
    if (this.isLogin()) {
      this.login(this.username!,this.password!)
    }
  }

  async login(name:string,psw:string):Promise<LoginWrap> {
    const value: AxiosResponse = await CommonServices.login(name, psw)
    const wrap = value.data as LoginWrap
    if (wrap.errorCode == 0) {
      const cookie = JSONUtil.beanToJsonStr(value.headers["set-cookie"]).replaceAll("\[\"", "")
        .replaceAll("\"\]", "")
        .replaceAll("\",\"", "; ")
      SpUtil.setUserName(name)
      SpUtil.setPassword(psw)
      SpUtil.setCookie(cookie)
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
}