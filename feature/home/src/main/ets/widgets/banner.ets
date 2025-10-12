import { HomeBannerBean } from "helper/src/main/ets/models/home_banner"

@ComponentV2
export struct HomeBannerWidget {
  @Param @Require list: HomeBannerBean[]

  build() {
    Swiper() {
      ForEach(this.list, (item: HomeBannerBean) => {
        Image(item.imagePath).width('100%').height('').objectFit(ImageFit.Cover)
      })
    }
    .loop(true)
    .autoPlay(true)
  }
}