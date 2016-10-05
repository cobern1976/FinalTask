﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Обмен данными в модели сервиса".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Устарела. Следует использовать ПриОпределенииТребуемойВерсииПриложения
//
Функция ТребуемаяВерсияПриложения() Экспорт
	
КонецФункции

// Определяет версию приложения 1С:Предприятия, которая требуется для работы автономного рабочего
// места. Приложение этой версии должно быть установлено на локальном компьютере пользователя.
// Если возвращаемое значение функции не задано, то в качестве требуемой версии приложения
// будет использоваться значение по умолчанию: первые три цифры версии текущего приложения,
// расположенного в Интернете, например, "8.3.3".
// Используется в помощнике создания автономного рабочего места.
//
// Параметры:
//	Версия - Строка - Версия требуемого приложения 1С:Предприятия в формате
//	<основная версия>.<младшая версия>.<релиз>.<дополнительный номер релиза>.
//	Например, "8.3.3.715".
//
Процедура ПриОпределенииТребуемойВерсииПриложения(Версия) Экспорт
	
КонецПроцедуры

#КонецОбласти