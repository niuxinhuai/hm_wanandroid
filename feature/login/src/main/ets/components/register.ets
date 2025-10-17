import { SmartDialog } from 'ohos_smart_dialog';
import { inputMethod } from '@kit.IMEKit';
import { ToastUtil } from '@pura/harmony-utils';
import { RegisterViewModel } from '../vm/RegisterViewModel';


@ComponentV2
export struct RegisterPage {

  private viewModel:RegisterViewModel = new RegisterViewModel()

  build() {
    Column() {
      Row() {
        Text('关闭')
          .fontSize(16)
          .backgroundColor(Color.Gray)
          .width(80)
          .height(30)
          .borderRadius(8)
          .onClick(() => {
            SmartDialog.dismiss({ tag: "" })
          })
          .textAlign(TextAlign.Center)
      }.width('90%')

      // 顶部Logo区域
      Image($r('app.media.icon'))
        .width(100)
        .height(100)
        .margin({ top: 100, bottom: 30 })

      // 标题区域
      Text('用户注册')
        .fontSize(24)
        .fontColor('#182431')
        .margin({ bottom: 8 })

      // 输入框区域
      TextInput({ placeholder: '请输入账号' })
        .width('90%')
        .height(50)
        .backgroundColor('#F0F2F4')
        .margin({ bottom: 15 })
        .onChange((value: string) => this.viewModel.username = value)

      TextInput({ placeholder: '请输入密码' })
        .width('90%')
        .height(50)
        .type(InputType.Password)
        .backgroundColor('#F0F2F4')
        .margin({ bottom: 30 })
        .onChange((value: string) => this.viewModel.password = value)

      TextInput({ placeholder: '请再次密码' })
        .width('90%')
        .height(50)
        .type(InputType.Password)
        .backgroundColor('#F0F2F4')
        .margin({ bottom: 30 })
        .onChange((value: string) => this.viewModel.re_password = value)

      // 登录按钮
      Button('立即注册', { type: ButtonType.Capsule })
        .width('90%')
        .height(50)
        .backgroundColor('#007BFF')
        .fontColor('#FFFFFF')
        .onClick(() => this.viewModel.handleRegister())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF').onClick(() => {
      inputMethod.getController().stopInputSession()
    })
  }
}