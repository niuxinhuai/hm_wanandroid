import { AxiosResponse } from "@ohos/axios";
import { JSONUtil, ToastUtil } from "@pura/harmony-utils";
import { CommonServices, DefaultUser, SpUtil } from "helper";
import { LoginWrap } from "helper/src/main/ets/models/login";
import { SmartDialog } from "ohos_smart_dialog";
import { RegisterPage } from "../components/register";

@ObservedV2
export class LoginViewModel {
  @Trace username: string = '';
  @Trace password: string = '';
  private user: DefaultUser = DefaultUser.getInstance()

  async onCreate() {
    this.username = await SpUtil.getUserName()
    this.password = await SpUtil.getPassword()
  }

  private validateInput(): boolean {
    if (!this.username || !this.password) {
      ToastUtil.showToast('请输入账号和密码');
      return false;
    }
    return true;
  }

  handleLogin() {
    if (!this.validateInput()) {
      return;
    }
    this.toLogin()
  }

  private async toLogin() {
    const wrap = await DefaultUser.getInstance().login(this.username, this.password)
    if (wrap.errorCode == 0) {
      ToastUtil.showToast('登录成功')
      SmartDialog.dismiss()
    } else if (wrap.errorCode == -1) {
      ToastUtil.showToast(wrap.errorMsg ?? '登录出错，请重试')
    }
  }
}

export function toRegister() {
  SmartDialog.show({
    builder: buildRegisterPage,
    tag: "register"
  })
}

@Builder
function buildRegisterPage() {
  RegisterPage()
}