﻿#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Значения реквизитов формы
	РежимРаботы = ОбщегоНазначенияПовтИсп.РежимРаботыПрограммы();
	РежимРаботы = Новый ФиксированнаяСтруктура(РежимРаботы);
	
	// СтандартныеПодсистемы.ФайловыеФункции
	МаксимальныйРазмерФайла              = ФайловыеФункции.МаксимальныйРазмерФайлаОбщий() / (1024*1024);
	МаксимальныйРазмерФайлаОбластиДанных = ФайловыеФункции.МаксимальныйРазмерФайла() / (1024*1024);
	Если РежимРаботы.МодельСервиса Тогда
		Элементы.МаксимальныйРазмерФайла.МаксимальноеЗначение = МаксимальныйРазмерФайла;
	КонецЕсли;
	ЗапрещатьЗагрузкуФайловПоРасширению = НаборКонстант.ЗапрещатьЗагрузкуФайловПоРасширению;
	// Конец СтандартныеПодсистемы.ФайловыеФункции
	
	// СтандартныеПодсистемы.ФайловыеФункции
	Элементы.ГруппаХранитьФайлыВТомахНаДиске.Видимость     = РежимРаботы.ЭтоАдминистраторСистемы;
	Элементы.ГруппаСправочникТомаХраненияФайлов.Видимость  = РежимРаботы.ЭтоАдминистраторСистемы;
	Элементы.ОбщиеПараметрыДляВсехОбластейДанных.Видимость = РежимРаботы.МодельСервиса И РежимРаботы.ЭтоАдминистраторСистемы;
	// Конец СтандартныеПодсистемы.ФайловыеФункции
	
	// Обновление состояния элементов.
	УстановитьДоступность();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// СтандартныеПодсистемы.ФайловыеФункции
&НаКлиенте
Процедура ХранитьФайлыВТомахНаДискеПриИзменении(Элемент)
	
	СтароеЗначение = Не НаборКонстант.ХранитьФайлыВТомахНаДиске;
	
	Попытка
		ЗапросыНаИспользованиеВнешнихРесурсов = 
			ЗапросыНаИспользованиеВнешнихРесурсовТомовХраненияФайлов(
				НаборКонстант.ХранитьФайлыВТомахНаДиске);
		
		РаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(
			ЗапросыНаИспользованиеВнешнихРесурсов, ЭтотОбъект, Новый ОписаниеОповещения(
				"ХранитьФайлыВТомахНаДискеПриИзмененииЗавершение", ЭтотОбъект, Элемент))
	Исключение
		НаборКонстант.ХранитьФайлыВТомахНаДиске = СтароеЗначение;
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапрещатьЗагрузкуФайловПоРасширениюПриИзменении(Элемент)
	
	Если Не ЗапрещатьЗагрузкуФайловПоРасширению Тогда
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Элемент", Элемент);
		Оповещение = Новый ОписаниеОповещения("ЗапрещатьЗагрузкуФайловПоРасширениюПослеПодтверждения", ЭтотОбъект, ДополнительныеПараметры);
		ПараметрыФормы = Новый Структура("Ключ", "ПриИзмененииСпискаЗапрещенныхРасширений");
		ОткрытьФорму("ОбщаяФорма.ПредупреждениеБезопасности", ПараметрыФормы, , , , , Оповещение);
		Возврат;
	КонецЕсли;
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура СинхронизироватьФайлыПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура СписокЗапрещенныхРасширенийОбластиДанныхПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура МаксимальныйРазмерФайлаОбластиДанныхПриИзменении(Элемент)
	Если МаксимальныйРазмерФайлаОбластиДанных = 0 Тогда
		ТекстСообщения = НСтр("ru = 'Поле ""Максимальный размер файла"" не заполнено.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ,"МаксимальныйРазмерФайлаОбластиДанных");
		Возврат;
	КонецЕсли;
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура СписокРасширенийФайловOpenDocumentОбластиДанныхПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура СписокРасширенийТекстовыхФайловПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ФайловыеФункции

////////////////////////////////////////////////////////////////////////////////
// Общие параметры для всех областей данных.

// СтандартныеПодсистемы.ФайловыеФункции
&НаКлиенте
Процедура МаксимальныйРазмерФайлаПриИзменении(Элемент)
	Если МаксимальныйРазмерФайла = 0 Тогда
		ТекстСообщения = НСтр("ru = 'Поле ""Максимальный размер файла"" не заполнено.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ,"МаксимальныйРазмерФайла");
		Возврат;
	КонецЕсли;
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура СписокЗапрещенныхРасширенийПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура СписокРасширенийФайловOpenDocumentПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ФайловыеФункции

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ФайловыеФункции
&НаКлиенте
Процедура СправочникТомаХраненияФайлов(Команда)
	ОткрытьФорму("Справочник.ТомаХраненияФайлов.ФормаСписка", , ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаОчисткиФайлов(Команда)
	ОткрытьФорму("РегистрСведений.НастройкиОчисткиФайлов.ФормаСписка", , ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаСинхронизацииФайлов(Команда)
	ОткрытьФорму("РегистрСведений.НастройкиСинхронизацииФайлов.ФормаСписка", , ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.ФайловыеФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗапрещатьЗагрузкуФайловПоРасширениюПослеПодтверждения(Результат, ДополнительныеПараметры) Экспорт
	Если Результат <> Неопределено И Результат = "Продолжить" Тогда
		Подключаемый_ПриИзмененииРеквизита(ДополнительныеПараметры.Элемент);
	Иначе
		ЗапрещатьЗагрузкуФайловПоРасширению = Истина;
	КонецЕсли;
КонецПроцедуры

// СтандартныеПодсистемы.ФайловыеФункции
&НаКлиенте
Процедура ХранитьФайлыВТомахНаДискеПриИзмененииЗавершение(Ответ, Элемент) Экспорт
	
	Если Ответ <> КодВозвратаДиалога.ОК Тогда
		НаборКонстант.ХранитьФайлыВТомахНаДиске = Не НаборКонстант.ХранитьФайлыВТомахНаДиске;
	Иначе
		Подключаемый_ПриИзмененииРеквизита(Элемент);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗапросыНаИспользованиеВнешнихРесурсовТомовХраненияФайлов(Включение)
	
	ЗапросыНаИспользование = Новый Массив;
	
	Если Включение Тогда
		Справочники.ТомаХраненияФайлов.ДобавитьЗапросыНаИспользованиеВнешнихРесурсовВсехТомов(
			ЗапросыНаИспользование);
	Иначе
		Справочники.ТомаХраненияФайлов.ДобавитьЗапросыНаОтменуИспользованияВнешнихРесурсовВсехТомов(
			ЗапросыНаИспользование);
	КонецЕсли;
	
	Возврат ЗапросыНаИспользование;
	
КонецФункции

// Конец СтандартныеПодсистемы.ФайловыеФункции

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
	Если КонстантаИмя <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
	
	УстановитьДоступность(РеквизитПутьКДанным);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат "";
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
		
		// СтандартныеПодсистемы.ФайловыеФункции
		Если РеквизитПутьКДанным = "МаксимальныйРазмерФайла" Тогда
			НаборКонстант.МаксимальныйРазмерФайла = МаксимальныйРазмерФайла * (1024*1024);
			КонстантаИмя = "МаксимальныйРазмерФайла";
		ИначеЕсли РеквизитПутьКДанным = "МаксимальныйРазмерФайлаОбластиДанных" Тогда
			Если РежимРаботы.Локальный Или РежимРаботы.Автономный Тогда
				НаборКонстант.МаксимальныйРазмерФайла = МаксимальныйРазмерФайлаОбластиДанных * (1024*1024);
				КонстантаИмя = "МаксимальныйРазмерФайла";
			Иначе
				НаборКонстант.МаксимальныйРазмерФайлаОбластиДанных = МаксимальныйРазмерФайлаОбластиДанных * (1024*1024);
				КонстантаИмя = "МаксимальныйРазмерФайлаОбластиДанных";
			КонецЕсли;
		ИначеЕсли РеквизитПутьКДанным = "ЗапрещатьЗагрузкуФайловПоРасширению" Тогда
			НаборКонстант.ЗапрещатьЗагрузкуФайловПоРасширению = ЗапрещатьЗагрузкуФайловПоРасширению;
			КонстантаИмя = "ЗапрещатьЗагрузкуФайловПоРасширению";
		КонецЕсли;
		// Конец СтандартныеПодсистемы.ФайловыеФункции
		
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
	КонецЕсли;
	
	Возврат КонстантаИмя;
КонецФункции

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	// СтандартныеПодсистемы.ФайловыеФункции
	Если РеквизитПутьКДанным = "НаборКонстант.ХранитьФайлыВТомахНаДиске" ИЛИ РеквизитПутьКДанным = "" Тогда
		Элементы.СправочникТомаХраненияФайлов.Доступность = НаборКонстант.ХранитьФайлыВТомахНаДиске;
	КонецЕсли;

	Если РеквизитПутьКДанным = "ЗапрещатьЗагрузкуФайловПоРасширению" ИЛИ РеквизитПутьКДанным = "" Тогда
		Элементы.СписокЗапрещенныхРасширенийОбластиДанных.Доступность = ЗапрещатьЗагрузкуФайловПоРасширению;
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "НаборКонстант.СинхронизироватьФайлы" ИЛИ РеквизитПутьКДанным = "" Тогда
		Элементы.НастройкиСинхронизацииФайлов.Доступность = НаборКонстант.СинхронизироватьФайлы;
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ФайловыеФункции
	
КонецПроцедуры

#КонецОбласти
