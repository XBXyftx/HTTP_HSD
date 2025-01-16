import { http } from '@kit.NetworkKit';

interface row{
  "id": string
  "title": string
  "pic": string,
  "pic_w": string,
  "pic_h": string,
  "pic_t": string,
  "cate_id": string,
  "cTime": string,
  "uname": string,
  "uid": string,
  "downUrl": string,
  "timeStr": string
}
interface jsonHttp{
  "totalRow":number
  "rows":row[]
}

@Entry
@Component
struct JsonPage {
  @State message: string = 'Hello World';
  @State urlWeb: string = 'https://qianming.sinaapp.com/index.php/AndroidApi10/index/cid/qutu/lastid/'
  @State infos: jsonHttp = {totalRow:0,rows:[]}//自定义接口包含全部键值来强转

  build() {
    Column() {
      Row() {
        TextInput({ text: $$this.urlWeb, placeholder: '输入网址' })
          .width('80%')
        Button('访问')
          .type(ButtonType.Normal)
          .onClick(() => {
            let httpRequest = http.createHttp()
            httpRequest.request(this.urlWeb, (err, data) => {
              if (!err) {
                this.message = data.result.toString()
                this.infos = JSON.parse(this.message)
                console.log(this.message)
              } else {
                this.message = '访问出错' + JSON.stringify(err)
              }
            })
          })

      }
      List({space:20}){
        ForEach(this.infos.rows,(item:row,index)=>{
          ListItem(){
            Column() {
              Text(`row:id=${item.id}`)
              Text(item.title)
            }
            .alignItems(HorizontalAlign.Start)
          }
        })
      }
      .layoutWeight(1)
      .width('100%')

    }
    .height('100%')
    .width('100%')
  }
}