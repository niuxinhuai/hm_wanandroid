import { LoginViewModel, toRegister } from "../vm/LoginViewModel";
import { inputMethod } from '@kit.IMEKit'
import { SmartDialog } from 'ohos_smart_dialog';

@ComponentV2
export struct LoginPage {
  private viewModel: LoginViewModel = new LoginViewModel()

  aboutToAppear(): void {
    this.viewModel.onCreate()
  }

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
      Text('用户登录')
        .fontSize(24)
        .fontColor('#182431')
        .margin({ bottom: 8 })

      Text('请输入您的账号信息')
        .fontSize(16)
        .fontColor('#798189')
        .margin({ bottom: 40 })

      // 输入框区域
      TextInput({ placeholder: '请输入账号',text:this.viewModel.username })
        .width('90%')
        .height(50)
        .backgroundColor('#F0F2F4')
        .margin({ bottom: 15 })
        .onChange((value: string) => this.viewModel.username = value)

      TextInput({ placeholder: '请输入密码',text: this.viewModel.password})
        .width('90%')
        .height(50)
        .type(InputType.Password)
        .backgroundColor('#F0F2F4')
        .margin({ bottom: 30 })
        .onChange((value: string) => this.viewModel.password = value)

      Text('去注册').fontSize(16).fontColor('#666666').onClick(() => toRegister()).margin({ bottom: 20 }).width('90%').align(Alignment.Start)

      // 登录按钮
      Button('立即登录', { type: ButtonType.Capsule })
        .width('90%')
        .height(50)
        .backgroundColor('#007BFF')
        .fontColor('#FFFFFF')
        .onClick(() => this.viewModel.handleLogin())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF').onClick(() => {
      inputMethod.getController().stopInputSession()
    })
  }
}