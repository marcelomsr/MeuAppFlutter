class Acao {
  final int id;
  final String ticker;
  double precoMedio;
  int quantidade;
  double valorAtual;
  double porcentagemDaCarteira;
  double valorTotalPago;
  double valorTotalAtual;
  int quantidadeParaPrecoMedioFuturo;
  double dyUltimos12Meses;
  List<double> ultimosDividendosPago;
  DateTime ultimaDataCom;
  String observacao;

  Acao(
    this.id,
    this.ticker,
  );

  @override
  String toString() {
    return 'Acao { id: $id, ticker: $ticker}';
  }
}
