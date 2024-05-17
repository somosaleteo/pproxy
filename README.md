# Ice Cream Production App

This Flutter application demonstrates the Proxy design pattern using an ice cream production scenario. The app includes two types of ice creams: water-based and cream-based. Users can produce ice creams through authenticated and unauthenticated proxies, showcasing how access control and production prioritization work in real-world scenarios.
## Features

- Ice Cream Types: Produce water-based and cream-based ice creams.
- Proxy Design Pattern: Implemented to manage access and prioritize production based on queue length and authentication status.
- Modular Architecture: Clean separation of business logic, domain models, controllers, and UI components.

##Project Structure

    - lib
        - bussines_logic
            cream_ice_cream_machine.dart: Logic for producing cream-based ice creams.
            water_ice_cream_machine.dart: Logic for producing water-based ice creams.
        - controllers
            ice_cream_machine_proxy.dart: Proxy class to manage access and production logic.
        - domain
            - enums
                ingredients_enum.dart: Enum defining possible ice cream ingredients.
            - interfaces
                base_type.dart: Base type interface.
                ice_cream_model.dart: Interface for ice cream models.
            - models
                milk_based_ice_cream.dart: Model for cream-based ice creams.
                water_base_type.dart: Model for water-based types.
                water_based_ice_cream.dart: Model for water-based ice creams.
        - ui
            - pages
                ice_cream_page.dart: Page for authenticated ice cream production.
                my_home_page.dart: Home page with navigation buttons.
                unauthenticated_proxy_page.dart: Page for unauthenticated ice cream production.
            - widgets
                helado_widget.dart: Widget to display ice cream details.
                ice_cream_production_widget.dart: Widget for ice cream production logic.
        - main.dart: Main entry point of the application.

# How to Run

1. Clone the repository:

```bash
git clone https://github.com/your-username/ice-cream-production-app.git
cd ice-cream-production-app
```
1. Install dependencies:

```bash
  flutter pub get
```
1. Run the application:

```bash
    flutter run
```

## Screenshots

Soon include some screenshots of the app here to showcase the UI and functionalities.
## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
