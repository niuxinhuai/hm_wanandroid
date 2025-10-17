import { ToastUtil } from "@pura/harmony-utils";
import { CommonServices } from "helper";
import { SmartDialog } from "ohos_smart_dialog";

@ObservedV2
export class RegisterViewModel {

  @Trace username: string = '';
  @Trace password: string = '';
  @Trace re_password: string = '';

  private validateInput(): boolean {
    if (!this.username || !this.password || !this.re_password) {
      ToastUtil.showToast('请输入账号和密码');
      return false;
    }
    if (this.password.length < 6 || this.re_password.length < 6) {
      ToastUtil.showToast('密码不符合标准');
      return false;
    }
    if (this.password != this.re_password) {
      ToastUtil.showToast('两次输入的密码有误,请重试');
      return false;
    }
    return true;
  }

  public handleRegister() {
    if (!this.validateInput()) {
      return;
    }
    this.registerUser()
  }

  //注册
  private async registerUser() {
    const value = await CommonServices.register(this.username,this.password,this.re_password)
    if (value.errorCode == 0) {
      ToastUtil.showToast('注册成功，请登录')
      SmartDialog.dismiss()
    } else {
      ToastUtil.showToast(value.errorMsg ?? '注册出错，请重试')
    }
  }
}