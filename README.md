# Тестовое задание для IOS разработчика

## ToDo:
Создать мобильное приложение для IOS, состоящее из экрана, отображающего информацию, получаемую из внешнего источника данных.

### Приложение должно :
- Запросить внешний сервис (данные брать вот здесь: https://www.cbr-xml-daily.ru/daily_json.js) и отобразить полученные данные на экране по нажатию кнопки. 
- Сохранять полученные данные в локальную базу приложения БД: время запуска приложения, полученные курс рубля. 
(данные в бд должны быть сохранены в виде таблицы с полями соответствующих типов данных)
- Обработать ошибки сети (выводить сообщение, если соединение недоступно).
- При отсутствии сети – отобразить данные, сохраненные в локальной базе при последнем удачном соединении.
                
### Использовать технологии: 
-MVVM, RxSwift, Realm, желательно без использования Storyboard.

### Опубликовать результаты задания на github

## Result

### Зависимости

  - pod 'netfox'
  - pod 'SnapKit'
  - pod 'RxSwift'
  - pod 'RealmSwift'
  - pod 'DeviceKit'

## Screenshots
![Simulator Screenshot - iPhone 15 Plus - 2023-09-30 at 12 47 58](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/2508c611-ae6a-4d4d-b29f-1bc4dc302fa5)
![Simulator Screenshot - iPhone 15 Plus - 2023-09-30 at 13 40 52](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/76d8f308-5a1e-4769-87a9-38b4f48e9ef6)
![Simulator Screenshot - iPhone 15 Plus - 2023-09-30 at 13 40 59](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/b962d8b2-bbd3-42c2-bb4c-6c79a8dff938)

![Simulator Screenshot - iPhone 15 Plus - 2023-09-30 at 12 46 56](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/224430a9-9e14-43cd-abb9-6febec948b14)
![Simulator Screenshot - iPhone 15 Plus - 2023-09-30 at 12 46 59](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/a2a2ac05-f814-4446-84b7-9930876c0c7a)
![Simulator Screenshot - iPhone 15 Plus - 2023-09-30 at 12 47 03](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/f534f90b-cd82-4bea-8b61-3deafe969c32)

### Структура БД Realm
![Screenshot 2023-09-30 at 11 47 15](https://github.com/lexonerus/simpleExchangeRate/assets/26347340/d8deb68f-e6b7-4596-9fbb-5d67a75f65fa)








