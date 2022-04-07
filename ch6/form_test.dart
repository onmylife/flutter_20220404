import 'package:flutter/material.dart';

//유저 입력 데이터 추상화 Vo
class User {
  String? firstName;
  String? lastName;
  bool isCheck = false;
}

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen>{
  //Form 을 이용하려면 꼭 Form 에 key 를 대입해 주어야 한다..
  //Form 이 FormState 를 획득해서 validate(), save() 등의 함수를 호출.. 그때  key 이용..
  final _formKey = GlobalKey<FormState>();

  final _user = User();

  _save() {
    print('${_user.firstName}, ${_user.lastName}, ${_user.isCheck}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Form 의 도움을 받으려면 Form 하위 입력 위젯들이... FormField<TextField> 처럼 사용해야 한다.
          //TextField + FormField = TextFormField
          TextFormField(
            decoration: InputDecoration(labelText: 'first name'),
            validator: (value){//매개변수가 그 순간 유저 입력 데이터..
              //유효성 검증 하고...
              //리턴값 - null - valid
              //리턴값 - 문자열 - invalid - 리턴한 문자열은 알아서 TextField 하위에 빨강색으로 잘 출력..
              if(value?.isEmpty ?? false) {
                return 'please enter first name';
              }
              return null;
            },
            onSaved: (val) {
              setState(() {
                _user.firstName = val;
              });
            }
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'last name'),
            validator: (value){
              if(value?.isEmpty ?? false){
                return 'please enter last name';
              }
              return null;
            },
            onSaved: (val){
              setState(() {
                _user.lastName = val;
              });
            },
          ),
          SwitchListTile(//XXXListTile 의 클래스들은 하나의 항목처럼 보이게 해준다..
            //대표적으로 ListView 를 구성할때 하나의 항목은 ListTile 로 많이 한다..
              title: Text('check'),
              value: _user.isCheck, //초기값이기도 하면서.. 변경된 값...
              onChanged: (bool val){
                setState(() {
                  _user.isCheck = val;
                });
              }
          ),
          ElevatedButton(//음영 처리로 위에 떠있는 듯한..
              onPressed: (){
                //FormState 획득...
                final form = _formKey.currentState;
                //유효성 검증..
                if(form?.validate() ?? false){//true 가 나오면 form 하위의 모든 데이터 입력이 유효하다는 이야기..
                  //false 가 나오면... form 하위 유저 입력중 하나 이상이 invalid 하다...
                  //validate() 가 호출이 되면 form 하위의 FormField 에 선언된 모든 validator 함수가 호출된다.
                  form?.save();//이렇게 되면.. form 하위의 모든 FormField 의 onSaved 함수가 호출이되면서
                  //매개변수로.. 유저 입력 데이터 전달..
                  _save();
                }
              },
              child: Text('SAVE')
          )
        ],
      ),
    );
  }

}





