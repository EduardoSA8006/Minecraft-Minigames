class Item {
  final Map<String, String> nome;
  final String id;
  final int stackSize;
  final String categoria;
  final String versaoAdicao;
  final List<String> ondeEncontrado;
  final String imagem;
  final String descricao;
  final String raridade;
  final int? durabilidade;
  final bool renovavel;
  final Map<String, String>? crafting;

  Item({
    required this.nome,
    required this.id,
    required this.stackSize,
    required this.categoria,
    required this.versaoAdicao,
    required this.ondeEncontrado,
    required this.imagem,
    required this.descricao,
    required this.raridade,
    this.durabilidade,
    required this.renovavel,
    this.crafting,
  });

  factory Item.fromJson({required Map<String, dynamic> json}) {
    return Item(
      nome: Map<String, String>.from(json['nome'] ?? {}),
      id: json['id'] ?? '',
      stackSize: json['stack_size'] ?? 64,
      categoria: json['categoria'] ?? 'outros',
      versaoAdicao: json['versao_adicao'] ?? '1.0',
      ondeEncontrado: List<String>.from(json['onde_encontrado'] ?? []),
      imagem: json['imagem'] ?? '',
      descricao: json['descricao'] ?? '',
      raridade: json['raridade'] ?? 'comum',
      durabilidade: json['durabilidade'],
      renovavel: json['renovavel'] ?? false,
      crafting: json['crafting'] != null
          ? Map<String, String>.from(json['crafting'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'id': id,
      'stack_size': stackSize,
      'categoria': categoria,
      'versao_adicao': versaoAdicao,
      'onde_encontrado': ondeEncontrado,
      'imagem': imagem,
      'descricao': descricao,
      'raridade': raridade,
      'durabilidade': durabilidade,
      'renovavel': renovavel,
      'crafting': crafting,
    };
  }

  Item copyWith({
    required Map<String, String>? nome,
    required String? id,
    required int? stackSize,
    required String? categoria,
    required String? versaoAdicao,
    required List<String> ondeEncontrado,
    required String? imagem,
    required String? descricao,
    required String? raridade,
    required int? durabilidade,
    required bool? renovavel,
    required Map<String, String>? crafting,
  }) {
    return Item(
      nome: nome ?? this.nome,
      id: id ?? this.id,
      stackSize: stackSize ?? this.stackSize,
      categoria: categoria ?? this.categoria,
      versaoAdicao: versaoAdicao ?? this.versaoAdicao,
      ondeEncontrado: ondeEncontrado,
      imagem: imagem ?? this.imagem,
      descricao: descricao ?? this.descricao,
      raridade: raridade ?? this.raridade,
      durabilidade: durabilidade ?? this.durabilidade,
      renovavel: renovavel ?? this.renovavel,
      crafting: crafting ?? this.crafting,
    );
  }

  @override
  String toString() => 'Item($id, ${nome['pt']})';
}
