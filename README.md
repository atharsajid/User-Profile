# User Profile

A new Flutter project.

## Getting Started

This Project consists two screens Profile Screen and Profile View.
flutter_bloc is being used for a state management.
Firebase is being used for Data Storage.

Profile Screen:
In profile screen user can upload image, name and valid email address, if anything is invalid or empty, user will receive warning message.

Profile View:
When user uploaded data, it will auto navigate to Profile View Screen where Uploaded data fetch from firebase and shows in Screen.

Services:
There is a services folder where common functions and classes are defined which can use any where in the project.

ProfileScreenModel:
ProfileScreenModel is being user an encapsulation where variables and functions are defined and referenced in Screens.

UserBloc:
When UploadImageEvent or UploadDataEvent calls, then bloc run the functions depend on event and emit state according to the result. Screens receive state from bloc and set state of the screen accordingly.

Widgets:
Widgets are defined as custom widgets which can use through out the project and avoid repeated code.