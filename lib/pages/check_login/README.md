# CheckLogin()

This widget is special. It checks if there are stored credentials (via SharedPreferences) and shows either
- **`HomePage()` widget:** if login with the stored creds was successful)
- **`LandingPage()` widget:** if login with the stored creds was not successful or if there were no stored credentials

Please please please never use this outside of the `lib/routing.dart` file. You would be doing a whole lot of unnecessary work

The `HomePage` and `LandingPage` widgets have been moved to this directory as well because they are probably not ever going to be used outside of `CheckLogin`. And if they are, importing them from `**/*/check_login` will serve as a reminder that they are not to be used outside of `CheckLogin`
