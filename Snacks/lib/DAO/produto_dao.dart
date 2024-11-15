class Lote {
  DateTime? dataCompra;
  DateTime? validade;
  num? precoCompra;
  String? localCompra;
}

class ProdutoDAO {
  bool       ativo = true;
  // Timestamp? dataCompra;
  String?    descricao;
  String?    id;
  String?    linkImagem;
  // String?    localCompra;
  // List<Lote> lote = [];
  String?    nome;
  num?       precoVenda;
  String?    qrCodeLink;
  int        qtd = 0;
  int?       tempoPreparo;
  String?    tipo;
  // Timestamp? validade;

  ProdutoDAO({this.nome, this.precoVenda = 0, this.descricao = 'Produto sem descrição...', this.tempoPreparo = 0, this.qtd = 1, this.linkImagem = '', this.qrCodeLink, this.tipo, this.id});

  ProdutoDAO.fromDocument(Map data,String? docId) {
    if (docId                != null) id           = docId;
    if (data['ativo']        != null) ativo        = data['ativo']        as bool;
    if (data['descricao']    != null) descricao    = data['descricao']    as String;
    if (data['linkImagem']   != null) linkImagem   = data['linkImagem']   as String;
    if (data['nome']         != null) nome         = data['nome']         as String;
    if (data['precoVenda']   != null) precoVenda   = data['precoVenda']   as num;
    if (data['qrCodeLink']   != null) qrCodeLink   = data['qrCodeLink']   as String;
    if (data['qtd']          != null) qtd          = data['qtd']          as int;
    if (data['tempoPreparo'] != null) tempoPreparo = data['tempoPreparo'] as int;
    if (data['tipo']         != null) tipo         = data['tipo']         as String;
  }
  
  Map<String, dynamic> toMap() {
    return {
                                'ativo'        : ativo,
      if (descricao    != null) 'descricao'    : descricao ,
      if (linkImagem   != null) 'linkImagem'   : linkImagem,
      if (nome         != null) 'nome'         : nome,
      if (precoVenda   != null) 'precoVenda'   : precoVenda,
      if (qrCodeLink   != null) 'qrCodeLink'   : qrCodeLink,
                                'qtd'          : qtd,
      if (tempoPreparo != null) 'tempoPreparo' : tempoPreparo,
      if (tipo         != null) 'tipo'         : tipo,
    };
  }
}

