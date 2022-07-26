class Memory {
  static const operations = const ['%', '/', 'x', '-', '+', '='];
  // OS DOIS PONTOS NO MEIO DA LINHA DE CÓDIGO SEM SER ATRAVÉS DE UM COMANDO SIGNIFICAM 'CASO CONTRÁRIO'
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? _operation;
  String _value = '0';
  bool _wipeValue = false;
  String? _lastCommand;

  void applyCommand(String command) {
    //COMANDOS APLICADOS
    if (_isReplaceOperation(command)) {
      _operation = command;
      return;
    } else if (command == 'AC') {
      //introduzinho método para limpar a tela
      _allClear();
    } else if (operations.contains(command)) {
      //introduzindo método para add operação
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _isReplaceOperation(String command) {
    //Permite a substituição de operação
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';
    //meu buffer eu tenho duas janelas de valores [0.0, 0.0], qualquer alteração feita, é sofrida pela primeira janela, agora temos que fazer com que quando colocarmos a operação ele migre para a segunda
    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1; //feito
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString(); //mostra valor da operação na tela
      _value = _value.endsWith('.0')
          ? _value.split('.')[0]
          : _value; //TIRAR O .0, CASO O RESULTADO SEJA INTEIRO
      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }
    _wipeValue = true; //!isEqualSign;
  } //método para add operação

  _addDigit(String digit) {
    final isDot = digit == '.';
    final wipeValue = (_value == '0' &&
            !isDot) || //Se for 0 e não for '.', tudo bem, logo essa parte permite a inclusão dos número decimais com 0, como 0.5 e etc
        _wipeValue; //substituição do 0 no número desejado

    if (isDot && _value.contains('.') && !wipeValue) {
      // Não permitir mais que um ponto/ mas quando eu clico em uma operação ele pode add um ponto, claro com o 0 na frente
      return;
    }
    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue
        ? emptyValue
        : _value; //Essas duas linhas acima corrigem o problema do 0., fazendo com que quando apertemos qualquer operação nos seja permitido apertar somente no '.' e ser gerado '0.'
    //? ''
    //: _value; //Se wipevalue estiver setado ele vai alterar o valor pra '' caso contrário para value
    _value = currentValue + digit; //Setando o valor do 0
    _wipeValue =
        false; //Logo essas 3 linhas significam que quando eu adicionar uma operação, os números add ficaram na memória e os novos
    //aparecerão para vc digitar

    _buffer[_bufferIndex] = double.tryParse(_value) ??
        0; //_bufferIndex para setar o valor, caso não consiga converter para double o valor ele mostrará 0
  }

  _allClear() {
    //método para limpar a tela
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  } //Apaga a memória da minha calculadora

  _calculate() {
    //OPERAÇÕES
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  String get value {
    return _value;
  }
}
