﻿
////////////////////////////////////////////////////////////////////////////////
// Подсистема "Взаимодействия"
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Обработчик события при записи учетной записи электронной почты.
Процедура ПриЗаписиУчетнойЗаписиЭлектроннойПочты(Источник, Отказ) Экспорт

	Если Источник.ОбменДанными.Загрузка Тогда
	
		Возврат;
	
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	ПапкиЭлектронныхПисем.Ссылка
	               |ИЗ
	               |	Справочник.ПапкиЭлектронныхПисем КАК ПапкиЭлектронныхПисем
	               |ГДЕ
	               |	ПапкиЭлектронныхПисем.ПредопределеннаяПапка
	               |	И ПапкиЭлектронныхПисем.Владелец = &УчетнаяЗапись";
	
	Запрос.УстановитьПараметр("УчетнаяЗапись",Источник.Ссылка);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		УправлениеЭлектроннойПочтой.СоздатьПредопределенныеПапкиЭлектронныхПисемДляУчетнойЗаписи(Источник.Ссылка);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
