import { CommonServices } from "helper";
import { WeChartWrap } from "helper/src/main/ets/models/we_chat";

@ObservedV2
export class WeChartViewModel {

  @Trace wrap?: WeChartWrap

  onCreate() {
    this.request()
  }

  async request() {
    this.wrap = await CommonServices.getWeChartTab()
    console.log(">>>>>>>>>count:" + this.wrap?.data?.length)
  }
}