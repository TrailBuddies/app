# CheckLogin()

This widget is special. It checks if there are stored credentials (via SharedPreferences) and shows either
- **`HomePage()` widget:** if login with the stored creds was successful)
- **`LoginPage()` widget:** if login with the stored creds was not successful or if there were no stored credentials

Please please please never use this outside of the `lib/routing.dart` file. You would be doing a whole lot of unnecessary work
