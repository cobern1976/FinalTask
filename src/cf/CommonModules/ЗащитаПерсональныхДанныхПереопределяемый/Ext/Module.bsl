﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Защита персональных данных".
// Модуль предназначен для размещения переопределяемых процедур подсистемы.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Процедура обеспечивает сбор сведений о хранении данных, 
// относящихся к персональным
//
// Параметры:
//		ТаблицаСведений - таблица значений с полями:
//			Объект 			- строка, содержащая полное имя объекта метаданных,
//			ПоляРегистрации - строка, в которой перечислены имена полей регистрации, 
//								отдельные поля регистрации отделяются запятой,
//								альтернативные - символом "|",
//			ПоляДоступа		- строка, в которой перечислены через запятую имена полей доступа.
//			ОбластьДанных	- строка с идентификатором области данных, необязательно для заполнения.
//
Процедура ЗаполнитьСведенияОПерсональныхДанных(ТаблицаСведений) Экспорт
	
	// _Демо начало примера
	НовыеСведения = ТаблицаСведений.Добавить();
	НовыеСведения.Объект			= "Справочник._ДемоФизическиеЛица";
	НовыеСведения.ПоляРегистрации	= "Ссылка";
	НовыеСведения.ПоляДоступа		= "ДатаРождения";
	НовыеСведения.ОбластьДанных		= "ЛичныеДанные";
	
	НовыеСведения = ТаблицаСведений.Добавить();
	НовыеСведения.Объект			= "Справочник._ДемоФизическиеЛица";
	НовыеСведения.ПоляРегистрации	= "Ссылка";
	НовыеСведения.ПоляДоступа		= "СерияДокумента,НомерДокумента,КемВыданДокумент,ДатаВыдачиДокумента";
	НовыеСведения.ОбластьДанных		= "ПаспортныеДанные";
	// _Демо конец примера
	
КонецПроцедуры

// Процедура обеспечивает составление коллекции областей персональных данных.
//
// Параметры:
//		ОбластиПерсональныхДанных - таблица значений с полями:
//			Имя - идентификатор области данных.
//			Представление - пользовательское представление области данных.
//			Родитель - идентификатор родительской области данных.
//
Процедура ЗаполнитьОбластиПерсональныхДанных(ОбластиПерсональныхДанных) Экспорт
	
	// _Демо начало примера
	// Заполнение представлений для используемых областей.
	НоваяОбласть = ОбластиПерсональныхДанных.Добавить();
	НоваяОбласть.Имя = "ЛичныеДанные";
	НоваяОбласть.Представление = НСтр("ru = 'Личные данные'");
	
	НоваяОбласть = ОбластиПерсональныхДанных.Добавить();
	НоваяОбласть.Имя = "ПаспортныеДанные";
	НоваяОбласть.Представление = НСтр("ru = 'Паспортные данные'");
	НоваяОбласть.Родитель = "ЛичныеДанные";
	// _Демо конец примера
	
КонецПроцедуры

// Процедура вызывается при заполнении формы "Согласие на обработку персональных данных"
//  данными, переданных в качестве параметров, субъектов.
//
// Параметры:
//		СубъектыПерсональныхДанных 	- данные формы коллекция, содержащая сведения о субъектах.
//		ДатаАктуальности			- дата, на которую нужно заполнить сведения.
//
Процедура ДополнитьДанныеСубъектовПерсональныхДанных(СубъектыПерсональныхДанных, ДатаАктуальности) Экспорт
	
	// _Демо начало примера
	// Пример заполнения данных для субъектов типов: Физические лица, _ДемоКонтактныеЛицаПартнеров, _ДемоКонтрагенты,
	// _ДемоПартнеры.
	Для Каждого СтрокаСубъект Из СубъектыПерсональныхДанных Цикл
		Если ТипЗнч(СтрокаСубъект.Субъект) = Тип("СправочникСсылка._ДемоФизическиеЛица") Тогда
			ИменаРеквизитов = "Наименование, СерияДокумента, НомерДокумента, КемВыданДокумент, ДатаВыдачиДокумента";
			ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(СтрокаСубъект.Субъект, ИменаРеквизитов);
			// Заполнение реквизитов.
			СтрокаСубъект.ФИО = ЗначенияРеквизитов.Наименование;
			Если ЗначениеЗаполнено(ЗначенияРеквизитов.СерияДокумента)
				Или ЗначениеЗаполнено(ЗначенияРеквизитов.НомерДокумента)
				Или ЗначениеЗаполнено(ЗначенияРеквизитов.КемВыданДокумент)
				Или ЗначениеЗаполнено(ЗначенияРеквизитов.ДатаВыдачиДокумента) Тогда
				СтрокаСубъект.ПаспортныеДанные = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Серия %1, номер %2, выдан %3 %4'"), 
					ЗначенияРеквизитов.СерияДокумента, 
					ЗначенияРеквизитов.НомерДокумента, 
					ЗначенияРеквизитов.КемВыданДокумент, 
					Формат(ЗначенияРеквизитов.ДатаВыдачиДокумента, "ДЛФ=D"));
			КонецЕсли;
		ИначеЕсли ТипЗнч(СтрокаСубъект.Субъект) = Тип("СправочникСсылка._ДемоКонтактныеЛицаПартнеров") Тогда
			ФизическоеЛицо = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаСубъект.Субъект, "ФизическоеЛицо");
			СтрокаСубъект.ФИО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ФизическоеЛицо, "Наименование");
			СтрокаСубъект.Адрес = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(СтрокаСубъект.Субъект, Справочники.ВидыКонтактнойИнформации._ДемоАдресКонтактногоЛица);
		ИначеЕсли ТипЗнч(СтрокаСубъект.Субъект) = Тип("СправочникСсылка._ДемоКонтрагенты") Тогда	
			СтрокаСубъект.ФИО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаСубъект.Субъект, "Наименование");
			СтрокаСубъект.Адрес = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(СтрокаСубъект.Субъект, Справочники.ВидыКонтактнойИнформации._ДемоАдресКонтрагента);
		ИначеЕсли ТипЗнч(СтрокаСубъект.Субъект) = Тип("СправочникСсылка._ДемоПартнеры") Тогда	
			СтрокаСубъект.ФИО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаСубъект.Субъект, "Наименование");
			СтрокаСубъект.Адрес = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(СтрокаСубъект.Субъект, Справочники.ВидыКонтактнойИнформации._ДемоАдресПартнера);
		КонецЕсли;
	КонецЦикла;
	// _Демо конец примера
	
КонецПроцедуры

// Процедура вызывается при заполнении формы "Согласие на обработку персональных данных"
//  данными организации.
//
// Параметры:
//		Организация					- организация - оператор персональных данных.
//		ДанныеОрганизации			- структура с данными об организации (адрес, ФИО ответственного и т.д.).
//		ДатаАктуальности			- дата, на которую нужно заполнить сведения.
//
Процедура ДополнитьДанныеОрганизацииОператораПерсональныхДанных(Организация, ДанныеОрганизации, ДатаАктуальности) Экспорт
	
	// _Демо начало примера
	ДанныеОрганизации.Вставить("АдресОрганизации", УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(Организация, Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации));
	// _Демо конец примера

КонецПроцедуры

#КонецОбласти
