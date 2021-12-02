//
//  Localization.swift
//  TyreService
//
//  Created by Kirill Severin on 15.10.21.
//

import Foundation

enum Errors {
    static let emptyName = "Введите ваше имя"
    static let emptyOrIncorrectPhone = "Введите ваш номер телефона с кодом, или проверьте его корректность"
    static let emptyField = "Введите описание вашего сервиса"
    static let emptyOrIncorrectEmail = "Введите ваш email или проверьте его корректность"
    static let smallPassword = "Пароль должен содержать не менее шести символов"
    static let emptyOrIncorrectAddress = "Введите ваш домашний адрес, с указанием города, улицы, дома и квартиры"
    static let emptyWorkingHours = "Введите время работы"
    static let emptyCoordinates = "Введите координаты"
    static let failedToLoadListOfServices = "Не удалось загрузить список сервисов "
    static let noDataSaved = "Не удалось сохранить информацию"
    static let dataSuccessfullySaved = "Данные успешно сохранены"
    static let imageSuccessSave = "Фотография успешно обновлена"
    static let imageErrorSave = "Фотография не обновлена"
    static let somethingWentWrong = "Что-то пошло не так"
    static let registrationFailed = "Ошибка регистрации"
    static let authorizationError = "Ошибка авторизации"
    static let errorLoadData = "Ошибка загрузки данных"
}
