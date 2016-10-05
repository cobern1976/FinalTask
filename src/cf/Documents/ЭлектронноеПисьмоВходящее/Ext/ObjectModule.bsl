﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Взаимодействия.ПриЗаписиДокумента(ЭтотОбъект);
	УправлениеЭлектроннойПочтой.УстановитьПометкуУдаленияУВложенийПисьма(Ссылка, ПометкаУдаления);
	Взаимодействия.ОтработатьПризнакИзмененияПометкиУдаленияПриЗаписиПисьма(ЭтотОбъект);
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	УправлениеЭлектроннойПочтой.УдалитьВложенияУПисьма(Ссылка);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("ПометкаУдаления",
		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка,"ПометкаУдаления"));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// _Демо начало примера
// Подсистема "Управление доступом".

// См. описание в комментарии к одноименной процедуре в модуле УправлениеДоступом.
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт

	// Логика ограничения следующая: объект доступен если доступен  "Ответственный" или "Учетная запись".
	// Логика "ИЛИ" реализуется через различные номера наборов.

	// Ограничение по "УчетныеЗаписиЭлектроннойПочты".
	НомерНабора = 1;

	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.НомерНабора     = НомерНабора;
	СтрокаТаб.ЗначениеДоступа = УчетнаяЗапись;

	// Ограничение по "Ответственный".
	НомерНабора = НомерНабора + 1;

	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.НомерНабора     = НомерНабора;
	СтрокаТаб.ЗначениеДоступа = Ответственный;

	МассивКонтактныхЛиц = Новый Массив;

	МассивТабличныхЧастей = Новый Массив;
	МассивТабличныхЧастей.Добавить("ПолучателиПисьма");
	МассивТабличныхЧастей.Добавить("ПолучателиКопий");
	МассивТабличныхЧастей.Добавить("ПолучателиОтвета");
	Для Каждого ТабличнаяЧасть Из МассивТабличныхЧастей Цикл

		Для Каждого СтрокаТаблицы Из ЭтотОбъект[ТабличнаяЧасть] Цикл

			Если Не ЗначениеЗаполнено(СтрокаТаблицы.Контакт) Тогда
				Продолжить;
			КонецЕсли;

			Если ТипЗнч(СтрокаТаблицы.Контакт) = Тип("СправочникСсылка._ДемоПартнеры") Тогда

				НомерНабора = НомерНабора + 1;

				СтрокаТаб = Таблица.Добавить();
				СтрокаТаб.НомерНабора     = НомерНабора;
				СтрокаТаб.ЗначениеДоступа = СтрокаТаблицы.Контакт;

			ИначеЕсли ТипЗнч(СтрокаТаблицы.Контакт) = Тип("СправочникСсылка._ДемоКонтактныеЛицаПартнеров") Тогда

				МассивКонтактныхЛиц.Добавить(СтрокаТаблицы.Контакт);

			КонецЕсли;

		КонецЦикла;
	КонецЦикла;

	Если МассивКонтактныхЛиц.Количество() > 0 Тогда

		Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	КонтактныеЛицаПартнеров.Владелец КАК Партнер
		|ИЗ
		|	Справочник._ДемоКонтактныеЛицаПартнеров КАК КонтактныеЛицаПартнеров
		|ГДЕ
		|	КонтактныеЛицаПартнеров.Ссылка В(&МассивКонтактныхЛиц)
		|");
		Запрос.УстановитьПараметр("МассивКонтактныхЛиц", МассивКонтактныхЛиц);
		Выборка = Запрос.Выполнить().Выбрать();

		Пока Выборка.Следующий() Цикл

			НомерНабора = НомерНабора + 1;

			СтрокаТаб = Таблица.Добавить();
			СтрокаТаб.НомерНабора     = НомерНабора;
			СтрокаТаб.ЗначениеДоступа = Выборка.Партнер;

		КонецЦикла;

	КонецЕсли;
КонецПроцедуры

// Подсистема "Управление доступом".
// _Демо конец примера

#КонецОбласти

#КонецЕсли