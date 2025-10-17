import { LogUtils } from "@ohos/apng/src/main/ets/utils/LogUtils";
import axios, { AxiosInstance, AxiosProgressEvent, AxiosRequestConfig, AxiosResponse, FormData,
  InternalAxiosRequestConfig } from "@ohos/axios";
import { DefaultUser } from "../../../../Index";
import Uri from "../constants/uri";


export default class ServiceHelper {
  private instance: AxiosInstance

  constructor(config: AxiosRequestConfig) {
    //创建实例化对象
    this.instance = axios.create(config)
    this.instance.defaults.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=utf-8; application/json'
    //请求拦截
    this.instance.interceptors.request.use(async (config: InternalAxiosRequestConfig) => {
      LogUtils.getInstance().LOGI(`>>>>>>request:${JSON.stringify(config)}`)
      return config
    })
    //respose
    this.instance.interceptors.response.use((response: AxiosResponse) => {
      LogUtils.getInstance().LOGI(`>>>>>>response:${JSON.stringify(response.data)}`)
      return response
    })
  }

  // 封装post
  public async post<T>(path: string, data: ESObject): Promise<T> {
    this.instance.defaults.headers["Cookie"] = DefaultUser.getInstance().cookie ?? ''
    try {
      return await this.instance.post(path, data).then((value: AxiosResponse<T>) => {
        return value.data
      })
    } catch (e) {
      console.log(">>>>>>>>>>>POST请求错误" + JSON.stringify(e, null, 2))
      return Promise.reject(e);
    }
  }

  public async postNormal(path: string, data: ESObject): Promise<AxiosResponse> {
    try {
      return await this.instance.post(path, data).then((value: AxiosResponse) => {
        return value
      })
    } catch (e) {
      console.log(">>>>>>>>>>>POST请求错误" + JSON.stringify(e, null, 2))
      return Promise.reject(e);
    }
  }

  public async get<T>(path: string, queryParameters?: ESObject): Promise<T> {
    this.instance.defaults.headers["Cookie"] = DefaultUser.getInstance().cookie ?? ''
    try {
      return await this.instance.get(path, queryParameters).then((value: AxiosResponse<T>) => {
        console.log(">>>>>>>>>>>GET请求成功" + value.data)
        return value.data
      })
    } catch (e) {
      console.log(">>>>>>>>>>>GET请求错误" + JSON.stringify(e, null, 2))
      return Promise.reject(e);
    }
  }

  public async download<T>(url: string, savePath: string,
    onDownloadProgress?: (progressEvent: AxiosProgressEvent) => void): Promise<T> {
    return await axios({
      url: url,
      filePath: savePath,
      onDownloadProgress: onDownloadProgress,
    }).then((value: AxiosResponse<T>) => {
      return value.data
    })
  }

  public async upload<T>(url: string, formData?: FormData,
    onUploadProgress?: (progressEvent: AxiosProgressEvent) => void): Promise<T> {
    return await axios.post<string, AxiosResponse<T>, FormData>(url, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
      context: getContext(this),
      onUploadProgress: onUploadProgress
      // onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
      //
      //   console.info(progressEvent && progressEvent.loaded && progressEvent.total ?
      //     Math.ceil(progressEvent.loaded / progressEvent.total * 100) + '%' : '0%');
      // },
    }).then((res: AxiosResponse<T>) => {
      return res.data
    })
  }
}

export const apiRequest = new ServiceHelper({
  baseURL: Uri.baseUri,
  timeout: 60000,
  connectTimeout: 60000,
  readTimeout: 60000,
});