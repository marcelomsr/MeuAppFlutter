class Fii {
  final int id;
  final String ticker;
  double precoMedio;
  int quantidade;
  double valorAtual;
  double porcentagemNaCarteira;
  String tipoFii;
  double valorTotalPago;
  double valorTotalAtual;
  double valorPatrimonial;
  List<double> ultimosDividendosPorcentagem;
  List<double> ultimosDividendosValorPago;
  String ultimoMesAtualizadoDividendos;
  double precoSubscricao;
  double fatorSubscricao;
  int quantidadeParaPrecoMedioFuturo;
  String observacao;

  Fii(
    this.id,
    this.ticker,
  );

  @override
  String toString() {
    return 'Acao { id: $id, ticker: $ticker}';
  }
}
