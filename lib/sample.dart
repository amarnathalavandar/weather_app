package com.example.yourapp

import android.content.Context
import android.view.View
import com.google.android.gms.wallet.button.AddToGoogleWalletButton
import io.flutter.plugin.platform.PlatformView

class GoogleWalletButtonView(context: Context) : PlatformView {
    private val walletButton: AddToGoogleWalletButton = AddToGoogleWalletButton(context)

    override fun getView(): View {
        return walletButton
    }

    override fun dispose() {}
}
