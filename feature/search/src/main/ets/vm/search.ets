import { ArrayUtil, DialogUtil, StrUtil, ToastUtil } from "@pura/harmony-utils"
import { CommonServices, RouterConstants, RouterUtils, SpHelper } from "helper"
import { HotSearchWrap } from "helper/src/main/ets/models/search"
import { ButtonOptions } from "@ohos.arkui.advanced.Dialog"

@ObservedV2
export class SearchViewModel {

  @Trace hotWrap?:HotSearchWrap
  @Trace history?: string[] = []
  private historyCacheKey:string = 'oh_wanAndroid_search_key'

  onCreate() {
    this.requestHotSearch()
    this.getHistory()
  }

  public async deleteHistory() {
    if (ArrayUtil.isEmpty(this.history)) {
      ToastUtil.showToast('暂无历史记录哦～')
      return
    }

    //挽留弹框
    DialogUtil.showPrimaryDialog({
      message: "是否清理全部搜索历史记录？清空后将无法被恢复",
      primaryButton:{value:'确认删除',action:()=> {
        this.history = []
        SpHelper.putAsync(this.historyCacheKey,'')
      }},
      secondaryButton:{value: '取消',action:()=>{}}
    })
  }

  public async doSearch(keyword:string) {
    if (StrUtil.isEmpty(keyword)) {
      ToastUtil.showToast('搜索关键字不能为空')
      return
    }
    this.resetCache(keyword)
    RouterUtils.push(RouterConstants.search_result,{keyword:keyword})
  }

  private async requestHotSearch() {
    this.hotWrap = await CommonServices.getHotSearch()
  }

  private async getHistory() {
    const value = await SpHelper.getString(this.historyCacheKey)
    if (StrUtil.isNotEmpty(value) && value.includes(',')) {
      this.history = value.split(',')
    }
  }

  private async resetCache(keyword:string) {
    if (this.history?.includes(keyword)) {
      //找到当前下标
      const index = this.history.indexOf(keyword)
      //删除指定下标的数据
      this.history.splice(index,1)
      //相同数据，插入第一条
      this.history.unshift(keyword)
    } else {
      //插入第一条
      this.history?.unshift(keyword)
    }
    //如果长度大于15，超出则删除最后的数据
    if ((this.history?.length ?? 0) > 15) {
      this.history?.pop()
    }
  }

  onDisappear() {
    //将数据进行持久化存储
    if (ArrayUtil.isNotEmpty(this.history)) {
      SpHelper.putAsync(this.historyCacheKey,this.history!.join(','))
    }
  }

}