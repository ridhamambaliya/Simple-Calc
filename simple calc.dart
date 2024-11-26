import 'dart:core';
import 'package:flutter/material.dart';

class MainCalc extends StatefulWidget {
  MainCalc({super.key});
  @override
  State<MainCalc> createState() => _MainCalcState();
}

class _MainCalcState extends State<MainCalc> {
  stateManage(){
    setState(() {

    });
  }
  CalcLogic obj=new CalcLogic();
  String opr = "+-*/%";
  String _equation = "",
      checknum = "";
  bool _isfirstdigit = true,
      _isprintok = true,
      _isreadyans= false;
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    dynamic height = size.height;
    dynamic width = size.width;
    dynamic btn_height = height/2;
    dynamic btn_width = (width-20)/4;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(

            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child : Text(
                _equation,
                style: TextStyle(fontSize: 40.0),
              ),
              height: height/2,
              width: width,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: height/2,
              width: width,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('C',btn_height,btn_width),
                      _buildButton('AC',btn_height,btn_width),
                      _buildButton('%',btn_height,btn_width),
                      _buildButton('/',btn_height,btn_width),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('7',btn_height,btn_width),
                      _buildButton('8',btn_height,btn_width),
                      _buildButton('9',btn_height,btn_width),
                      _buildButton('*',btn_height,btn_width),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4',btn_height,btn_width),
                      _buildButton('5',btn_height,btn_width),
                      _buildButton('6',btn_height,btn_width),
                      _buildButton('-',btn_height,btn_width),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1',btn_height,btn_width),
                      _buildButton('2',btn_height,btn_width),
                      _buildButton('3',btn_height,btn_width),
                      _buildButton('+',btn_height,btn_width),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('0',btn_height,btn_width),
                      _buildButton('00',btn_height,btn_width),
                      _buildButton('.',btn_height,btn_width),
                      _buildButton('=',btn_height,btn_width)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildButton(String value,dynamic h,dynamic w) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 3, 2, 3),
      child: Container(
        height: h/6,
        width: w,
        child: OutlinedButton(
          onPressed: () {
            _isprintok = true;
            if (value == 'AC'){
              _isprintok = false;
              if (_equation.isNotEmpty){
                _equation="";
                _isfirstdigit = true;
              }
            }else if(value == 'C'){
              _isprintok = false;
              if (_equation.isNotEmpty){
                _equation=_equation.substring(0,_equation.length-1);
              }
            }else if(_isfirstdigit){
              _isfirstdigit = false;
              if(value == '.'){
                _equation += '0';
              }else if(opr.contains(value)){
                checknum = "";
                _equation += '0';
                _isfirstdigit = true;
              }else if(value == '='){
                _equation = 'Error';
                _isfirstdigit = true;
                _isprintok = false;
              }
              if(_isprintok){
                checknum += value;
                _equation += value;
                _isprintok = true;
              }
            }else{
              print('sec');
              if(opr.contains(value)){
                checknum = "";
                _isreadyans = true;
                _isfirstdigit = true;
                _isprintok = true;
              }else if(value == '.' && checknum.contains(value)){
                _isprintok = false;
              }
              if(value == '='){
                _isprintok=false;
                if(_isreadyans){
                  _equation = obj.solution(_equation)!;
                }
              }else if(_isprintok){
                print('print $value');
                checknum += value;
                _equation+=value;
              }
            }
            stateManage();
          },
          child: Center(
            child: Text(value, style: TextStyle(fontSize: 24,color: Colors.black),),
          ),
        ),
      ),
    );
  }
}

class CalcLogic {
  String? solution(String equation){
    print('solution');
    String opr = "+-*/%",ch = "",fvalue = "",svalue = "";
    bool ischempty = true;
    equation+='=';
    for(int i=0;i<equation.length;i++){
      print('hi');
      if(opr.contains(equation[i]) && ischempty){
        ch = equation[i];
        ischempty =false;
      }else if((opr.contains(equation[i]) || equation[i] == '=') && !ischempty){
        fvalue=get_ans(fvalue,svalue,ch)!;
        if(equation[i] != '='){
          ch=equation[i];
          svalue="";
        }
      }else if(ischempty){
        fvalue += equation[i];
      }else if(!ischempty){
        svalue += equation[i];
      }
    }
    return fvalue;
  }
  String? get_ans(String val1,String val2,ch){
    double ans;
    switch(ch){
      case '+': {
        ans=double.parse(val1)+double.parse(val2);
      }
      break;
      case '-': {
        ans= double.parse(val1)-double.parse(val2);
      }
      break;
      case '*': {
        ans= double.parse(val1)*double.parse(val2);
      }
      break;
      case '/': {
        if(val2 == '0')
          return 'Error';
        else
          ans= double.parse(val1)/double.parse(val2);
      }
      break;
      case '%': {
        ans= double.parse(val1)%double.parse(val2);
      }
      break;
      default: {
        return 'Error';
      }
    }
    return ans.toString();
  }
}