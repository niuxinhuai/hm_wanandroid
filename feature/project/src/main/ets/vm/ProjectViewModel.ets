import { CommonServices } from "helper";
import { ProjectWrap } from "helper/src/main/ets/models/project";

@ObservedV2
export class ProjectViewModel {

  @Trace wrap?: ProjectWrap

  onCreate() {
    this.request()
  }

  private async request() {
    this.wrap = await CommonServices.getProjectArticles()
  }


}