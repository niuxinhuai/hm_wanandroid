import { SpHelper } from "../../sp_helper/sp_helper";

class SpAppKey {
  static readonly _cookie = 'cookie'
  static readonly _expires = "expires";
  static readonly _username = "username";
  static readonly _password = "password";
}

export class SpUtil {
  static setCookie(value:string) {
    SpHelper.putAsync(SpAppKey._cookie,value)
  }

  static setCookieExpires(value:string) {
    SpHelper.putAsync(SpAppKey._expires,value)
  }

  static setUserName(value:string) {
    SpHelper.putAsync(SpAppKey._username,value)
  }

  static setPassword(value:string) {
    SpHelper.putAsync(SpAppKey._password,value)
  }

  static async getCookie():Promise<string> {
    return await SpHelper.getString(SpAppKey._cookie)
  }

  static async getCookieExpires():Promise<string> {
    return await SpHelper.getString(SpAppKey._expires)
  }

  static async getUserName():Promise<string> {
    return await SpHelper.getString(SpAppKey._username)
  }

  static async getPassword():Promise<string> {
    return await SpHelper.getString(SpAppKey._password)
  }
}