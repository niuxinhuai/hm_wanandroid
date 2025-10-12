import { CommonServices } from "helper";
import { NavigationWrap } from "helper/src/main/ets/models/navigation";

@ObservedV2
export class NavigationViewModel {

  @Trace wrap?:NavigationWrap

  onCreate() {
    this.request()
  }

  private async request() {
    this.wrap = await CommonServices.getNavigationData()
  }
}