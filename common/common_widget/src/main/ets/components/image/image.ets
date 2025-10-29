import { apng } from "@ohos/apng"

enum ImageMediaType {
  normal,
  //本地file路径
  file,
  //网络图
  net,
  //apng
  apng,
}

@ComponentV2
export struct ImageView {

  @BuilderParam @Require url:string
  @Param @Require imageWidth: string | number
  @Param @Require imageHeight: string | number
  @Param objectFit?: ImageFit = ImageFit.Fill
  @Param radius: number | string | LPX = 0
  @Local private imageType: ImageMediaType = ImageMediaType.normal

  aboutToAppear(): void {
    this.compare()
  }

  compare() {
    if (this.url.includes('file://')) {
      this.imageType = ImageMediaType.file
    } else if (this.url.includes('http://') || this.url.includes('https://')) {
      this.imageType = ImageMediaType.net
    } else if (this.url.includes('apng')) {
      this.imageType = ImageMediaType.apng
    }
  }

  build() {
    if (this.imageType == ImageMediaType.apng) {
      apng({
        src: this.url,
        apngWidth: this.imageWidth,
        apngHeight: this.imageHeight,
        speedRate: 1
      }).width(this.imageWidth).height(this.imageHeight)
    } else {
      Image(this.url)
        .width(this.imageWidth)
        .height(this.imageHeight)
        .objectFit(this.objectFit)
        .borderRadius(this.radius)
    }
  }
}