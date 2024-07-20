# COGIA technical assignment

### To do
1. Please user Xcode 15.4 to open the project
2. Open the project from ".xcworkspace"
3. Try `Xcode -> Files -> Packages -> Reset Package Caches` if any error encountered to build the project

### Design Consideration (MVVM + Rx)
The code consist 5 main elements:
1. View - view controller & views
2. ViewModel - view absract representation, manage user interaction and handle services & business logic
3. Model - data content
4. Services - perform specific tasks (services), eg: fetching data from API
5. Configurator & Wireframe - creating view and handle navigation between views
6. Both iPhone and iPad devices are supported
7. Both light and dark mode are supported

### Assumption
1. All json parse expected to be successful. Specific error handling is not implemented in the code.
2. All data loaded at once. Pagination not implemented.

## Application Design

### Module: Splash

**Life cycle** <br />
Entry point: App launch <br />
Navigate out: 2 seconds after view did appear to screen

### Module: User Listing

**Life cycle** <br />
Entry point: 2 seconds after Splash screen did appear <br />
Navigate out: Upon selection any of row in listing

**Element** 
1. Load data from `https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28#list-users` upon entry
2. Refresh view upon API call completion
3. Reload list from API upon pulling the listing

### Module: User Details

**Life cycle** <br />
Entry point: Item selected from listing screen <br />
Navigate out: Upon tapping back button

**Element** 
1. Load data from `https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28#get-a-user-using-their-id` upon entry
2. Refresh view upon API call completion
