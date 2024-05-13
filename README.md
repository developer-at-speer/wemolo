# Wemolo

Wemolo is a Flutter application designed to help users locate and evaluate parking lots. The project uses Material 3 design and the Flutter testing framework.

## Project Structure

Wemolo is organized into several key directories:

- **/models**: Contains data models used across the application. `ParkingLot` model represents the data structure for a parking lot.

- **/screens**: Houses the UI screens of the application.
  - **home_screen**: Fetches parking lot data five entries at a time, displaying each lot's image and metadata. It includes buttons for users to rate the parking lot as good or bad.
  - **summary_screen**: Displays parking lots categorized as either favorite(good) or dismissed(bad). These entries can be sorted by name, type, or filtered by active status. User can click on each card to go to the details screen.
  - **details_screen**: Displays enlarged image and metadata details.

- **/services**: Includes services that interact with external APIs.
  - **api_service**: Fetches parking lot data from a GraphQL API.

- **/utils**: Provides utility functions to manipulate parking lot data.
  - **parking_utils**: Includes functions such as `filterByStatus`, `sortByName`, `sortByType`, `groupByType`.

- **/mock_data**: Contains mock data used for testing and development.

- **/tests**: Contains a suite of tests, particularly focusing on the utility functions within the parking utils.


## Getting Started

To get started with Wemolo, ensure you have Flutter installed on your machine. Follow these steps to set up the project locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourgithub/wemolo.git
2. Navigate to the project directory:
   ```bash
   cd wemolo
3. Install dependencies:
   ```bash
   flutter pub get
4. Run the application:
   ```bash
   flutter run

## Testing

Wemolo uses the Flutter Test Framework for its testing suite. To run tests:

   ```bash
   flutter test