class ViewInAppleWalletPage extends StatelessWidget {
  const ViewInAppleWalletPage({super.key});




  @override
  Widget build(BuildContext context) {
    final l10n = OZLocalizations.of(context);
   

    return OZScaffold(
      title: l10n.smartKey_openDoorPage_title,
      actionIconData: ZIGIcons.more_vertical_24_solid,
      body: BlocProvider(
        create: (context) => locator<ViewInWalletCubit>()..checkPassesAvailability(),
        child: const ViewInAppleWalletMobileLayout(),
      ),
    );
  }
}
