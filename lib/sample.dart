ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
  ),
  icon: Image.asset('assets/google_wallet_icon.png', height: 24), // Add the Google Wallet logo separately
  label: const Text(
    'Agregar a la Billetera de Google',
    style: TextStyle(color: Colors.white),
  ),
  onPressed: () {
    print("Add to Google Wallet clicked!");
  },
),
