import 'package:flutter/material.dart';

//TODO: Adicionar comentarios no que ainda falta

void main() {
  runApp(MaterialApp(
    title: 'Calculadora de IMC',
    home: calcImc(), //inicia o statefull widget da pagina inicial
  ));
}

class calcImc extends StatefulWidget {
  @override
  _calcImcState createState() => _calcImcState();
}

class _calcImcState extends State<calcImc> {
  //Definindo as variaveis
  String _infoTexto = "Insira seus dados";
  //Definindo os controllers
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetarCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoTexto = "Insira seus dados";
    });
  }

  void _calcular() {
    double _peso = double.parse(pesoController.text);
    double _altura = double.parse(alturaController.text) / 100;

    double _imc = _peso / (_altura * _altura);

    setState(() {
      if (_imc < 18.5) {
        _infoTexto = "Abaixo do Peso (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 18.5 && _imc < 25) {
        _infoTexto = "Peso Normal (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 25 && _imc < 30) {
        _infoTexto = "Sobrepeso (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 30 && _imc < 35) {
        _infoTexto = "Obesidade Grau 1 (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 35 && _imc < 40) {
        _infoTexto = "Obesidade Grau 2 (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 40) {
        _infoTexto = "Obesidade Grau 3 (${_imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //inicia a AppBar do app
      appBar: AppBar(
        title: Text("Calculadora de IMC"), //Texto da parte superior
        centerTitle: true, //Centraliza o texto
        backgroundColor: Colors.green[500], //Define a cor para verde
        //onde os widgets da appbar com acoes ficam
        actions: <Widget>[
          //adiciona um botao com um icone de refresh
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetarCampos,
          ),
        ],
      ),
      backgroundColor: Colors.white, //Define branco como a cor de fundo
      //inicia o body
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            //Define o alinhamento para que tudo ocupe o maximo de espaco
            //possivel no eixo horizontal
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Adiciona um icone de uma pessoa, que nao fica esticado porque
              //seu tamanho foi especificado
              Icon(
                Icons.person_outline,
                color: Colors.green[500],
                size: 120.0,
              ),
              //Insere Input de peso
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle:
                      TextStyle(color: Colors.green[500], fontSize: 20.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green[500],
                  fontSize: 25.0,
                ),
                controller: pesoController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              //Insere Input de altura
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura(cm)",
                  labelStyle: TextStyle(
                    color: Colors.green[500],
                    fontSize: 20.0,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green[500],
                  fontSize: 25.0,
                ),
                controller: alturaController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),
              //Insere um botao para calcular
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green[500],
                  ),
                ),
              ),
              Text(
                _infoTexto,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[500], fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
