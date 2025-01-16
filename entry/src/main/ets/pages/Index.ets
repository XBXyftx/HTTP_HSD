import { http } from '@kit.NetworkKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State urlWeb:string = 'https://www.163.com'

  build() {
    Column(){
      Row(){
        TextInput({text:$$this.urlWeb,placeholder:'输入网址'})
          .width('80%')
        Button('访问')
          .type(ButtonType.Normal)
          .onClick(()=>{
            let httpRequest = http.createHttp()
            httpRequest.request(this.urlWeb,(err,data)=>{
              if (!err) {
                this.message = data.result.toString()
              }else {
                this.message = '访问出错'+JSON.stringify(err)
              }
            })
          })

      }
      Scroll(){
        Text(this.message)
      }

    }
    .height('100%')
    .width('100%')
  }
}