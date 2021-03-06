﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Календари.Ссылка
	|ИЗ
	|	Справочник.Календари КАК Календари";
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Календарь	= Выборка.Ссылка;
	КонецЕсли;
	
	Дата			= ТекущаяДатаСеанса();
	КоличествоДней	= 3;
	
	ТаблицаДатПоКалендарю.Добавить().КоличествоДней = 2;
	ТаблицаДатПоКалендарю.Добавить().КоличествоДней = 3;
	ТаблицаДатПоКалендарю.Добавить().КоличествоДней = 5;
	
	ДатыРабочихДней.Добавить().Дата = '20110818000000';
	ДатыРабочихДней.Добавить().Дата = '20110613000000';
	ДатыРабочихДней.Добавить().Дата = '20111104000000';
	
	ДатаНачала = ТекущаяДатаСеанса();
	ДатаОкончания = ДатаНачала + 7 * 86400; // 86400 - длина суток
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РассчитатьДату(Команда)
	
	Попытка
		ДатаПоКалендарю = ПолучитьДатуПоКалендарю(Календарь, Дата, КоличествоДней);
		
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()), Календарь);
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьМассивДат(Команда)
	
	Попытка
		МассивДней = Новый Массив;
		
		Для Каждого СтрокаТаблицы Из ТаблицаДатПоКалендарю Цикл
			МассивДней.Добавить(СтрокаТаблицы.КоличествоДней);
		КонецЦикла;
		
		МассивДат = ПолучитьМассивДатПоКалендарю(Календарь, Дата, МассивДней, РассчитыватьСледующуюДатуОтПредыдущей);
		
		Для Каждого СтрокаТаблицы Из ТаблицаДатПоКалендарю Цикл
			СтрокаТаблицы.ДатаПоКалендарю = МассивДат[ТаблицаДатПоКалендарю.Индекс(СтрокаТаблицы)];
		КонецЦикла;
		
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()), Календарь);
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьКоличествоДней(Команда)
	
	Попытка
		РазностьДат = ПолучитьРазностьДатКалендарю(Календарь, ДатаНачала, ДатаОкончания);
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()), Календарь);
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДатыРабочихДней(Команда)
	
	ЗаполнитьДатыРабочихДней();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Функция вызывает функцию общего модуля КалендарныеГрафики для получения даты по календарю.
//
// Параметры:
//	Календарь		- Объект формы - Календарь.
//	Дата			- Объект формы - Дата.
//	КоличествоДней	- объект формы - КоличествоДней.
//
// Возвращаемое значение
//	ДатаКалендаря	- дата, увеличенная на количество дней, входящих в график.
//
&НаСервереБезКонтекста
Функция ПолучитьДатуПоКалендарю(Календарь, Дата, КоличествоДней)
	
	Возврат КалендарныеГрафики.ПолучитьДатуПоКалендарю(Календарь, Дата, КоличествоДней);
	
КонецФункции

// Функция вызывает функцию общего модуля КалендарныеГрафики для получения массива дат по календарю.
//
// Параметры:
//	Календарь		- Объект формы - Календарь.
//	Дата			- Объект формы - Дата.
//	МассивДней		- Массив, в котором хранятся количества дней.
//
// Возвращаемое значение
//	МассивДат		- массив дат, увеличенных на количество дней, входящих в график.
//
&НаСервереБезКонтекста
Функция ПолучитьМассивДатПоКалендарю(Календарь, Дата, МассивДней, РассчитыватьСледующуюДатуОтПредыдущей)
	
	Возврат КалендарныеГрафики.ПолучитьМассивДатПоКалендарю(Календарь, Дата, МассивДней, РассчитыватьСледующуюДатуОтПредыдущей);
	
КонецФункции

// Функция вызывает функцию общего модуля КалендарныеГрафики для получения даты по календарю.
//
// Параметры:
//	Календарь		- Объект формы - Календарь.
//	Дата			- Объект формы - Дата.
//	КоличествоДней	- объект формы - КоличествоДней.
//
// Возвращаемое значение
//	ДатаКалендаря	- дата, увеличенная на количество дней, входящих в график.
//
&НаСервереБезКонтекста
Функция ПолучитьРазностьДатКалендарю(Календарь, ДатаНачала, ДатаОкончания)
	
	Возврат КалендарныеГрафики.ПолучитьРазностьДатПоКалендарю(Календарь, ДатаНачала, ДатаОкончания);
	
КонецФункции

&НаСервере
Процедура ЗаполнитьДатыРабочихДней()
	
	РабочиеДаты = КалендарныеГрафики.ПолучитьДатыРабочихДней(Календарь, ДатыРабочихДней.Выгрузить().ВыгрузитьКолонку("Дата"), ПолучатьПредшествующие);
	
	Для Каждого СтрокаТаблицы Из ДатыРабочихДней Цикл
		СтрокаТаблицы.РабочаяДата = РабочиеДаты[СтрокаТаблицы.Дата];
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
