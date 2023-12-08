import 'package:cc_clip_app/model/FormData.dart';
import 'package:flutter/material.dart';

class FormGenerate extends StatefulWidget {
  FormGenerate({
    super.key,
    required this.formData,
    this.padding = const EdgeInsets.only(left: 30, right: 30)
  });
  final List<FormData> formData;
  EdgeInsetsGeometry? padding;

  @override
  State<StatefulWidget> createState()  => FormGenerateState();
}
class FormGenerateState extends State<FormGenerate> {

  List<Widget> genFormItem(double width) {
    List<Widget> result = [];
    for(FormData formItem in widget.formData){
      InputType type = formItem.type;
      if(type == InputType.string) {
        result.add(
          Container(
            key: Key(formItem.key),
            padding: const EdgeInsets.only(bottom: 10),
            width: width,
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.grey[100],
                    decoration: InputDecoration(
                      icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(formItem.icon, color: Colors.grey[100], size: 28,),
                      ),
                      hintText: formItem.hintText,
                      helperText: formItem.helperText,
                      errorText: formItem.errorText,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }else if(type == InputType.password) {
        result.add(
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: width,
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.grey[100],
                    obscureText: true,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[200]
                    ),
                    decoration: InputDecoration(
                        icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Icon(formItem.icon, color: Colors.grey[100], size: 28,),
                        ),
                        hintText: formItem.hintText,
                        helperText: formItem.helperText,
                        errorText: formItem.errorText,
                        // suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[100], size: 24,)
                        suffixIcon: Icon(Icons.visibility_outlined, color: Colors.grey[100], size: 24,)
                    ),
                  ),
                )
              ],
            ),
          )
        );
      } else if(type == InputType.piCode){
        result.add(
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: width,
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      cursorHeight: 19,
                      cursorColor: Colors.grey[100],
                      obscureText: true,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[200]
                      ),
                      decoration: InputDecoration(
                          icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(formItem.icon, color: Colors.grey[100], size: 28,),
                          ),
                          hintText: formItem.hintText,
                          helperText: formItem.helperText,
                          errorText: formItem.errorText,
                          // suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[100], size: 24,)
                          suffixIcon: Icon(Icons.refresh, color: Colors.grey[100], size: 24,)
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    width: 110,
                    height: 46,
                    child: Image.asset('assets/image/flame-40.png', fit: BoxFit.fill,),
                  )
                ],
              ),
            )
        );
      }else if(type == InputType.button){
        result.add(
            Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                width: width,
                height: 80,
                child: Center(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey[800] as Color),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[900] as Color),
                      foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[200] as Color),
                      side: MaterialStateProperty.resolveWith((states) => BorderSide(width: 1.0, color: Colors.grey[200] as Color)),
                    ),
                    onPressed: () {},
                    child: Center(
                        child: Text('${formItem.buttonText}', style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          color: Colors.grey[100],
                          fontWeight: FontWeight.bold
                        ))
                    ),
                  ),
                )
            )
        );
      }
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
         padding: widget.padding,
         color: Colors.grey[900],
         width: width,
         height: height,
         child: Column(
             // crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(padding: EdgeInsets.only(top: 20), child: SizedBox()),
               ...genFormItem(width)
             ]
         ),
       ),
    );
  }
}