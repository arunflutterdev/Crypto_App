class CryptoCurrency {
  final String name;
  final String symbol;
  final double price;
  final bool hasLogo; // Add a boolean flag to check if the coin has a logo

  CryptoCurrency({
    required this.name,
    required this.symbol,
    required this.price,
    required this.hasLogo,
  });

  factory CryptoCurrency.fromMap(Map<String, dynamic> map) {
    // Assume all coins have logos for simplicity
    return CryptoCurrency(
      name: map['name'],
      symbol: map['symbol'],
      price: map['quote']['USD']['price'].toDouble(),
      hasLogo: true,
    );
  }
}
