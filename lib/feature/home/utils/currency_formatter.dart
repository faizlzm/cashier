class CurrencyFormatter {
  static String format(double amount) {
    // Konversi ke string tanpa desimal
    String amountStr = amount.toStringAsFixed(0);

    // Tambahkan pemisah ribuan (titik)
    String result = '';
    int count = 0;

    for (int i = amountStr.length - 1; i >= 0; i--) {
      if (count == 3) {
        result = '.$result';
        count = 0;
      }
      result = amountStr[i] + result;
      count++;
    }

    return 'Rp $result';
  }
}