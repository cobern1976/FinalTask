﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОпределитьОтображениеСпискаКонтактныхЛиц(Параметры.ТолькоСВнешнимДоступом);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОпределитьОтображениеСпискаКонтактныхЛиц(ТолькоСВнешнимДоступом)
	
	ТекстВыбрать = "";
	ТекстИз = "";
	ТекстГде = "";
	
	// Проверка на подсистему
	Если ПравоДоступа("Чтение", Метаданные.Справочники.ВнешниеПользователи) Тогда
		ТекстВыбрать = "ВЫРАЗИТЬ((ВЫРАЗИТЬ(НЕ ВнешниеПользователи.Ссылка ЕСТЬ NULL КАК БУЛЕВО)
		| И НЕ ВнешниеПользователи.Недействителен И НЕ ВнешниеПользователи.ПометкаУдаления) КАК БУЛЕВО) Как ВнешнийДоступ,";
		ТекстИз = " ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВнешниеПользователи КАК ВнешниеПользователи
		| ПО Справочник_ДемоКонтактныеЛицаПартнеров.Ссылка = ВнешниеПользователи.ОбъектАвторизации";
		Элементы.ВнешнийДоступ.Видимость = Истина;
		
		Если ТолькоСВнешнимДоступом Тогда
			ТекстГде = " ГДЕ ВЫРАЗИТЬ(НЕ ВнешниеПользователи.Ссылка ЕСТЬ NULL КАК БУЛЕВО)
			| И НЕ ВнешниеПользователи.Недействителен И НЕ ВнешниеПользователи.ПометкаУдаления = ИСТИНА";
		КонецЕсли;
	КонецЕсли;
	
	Список.ТекстЗапроса = "ВЫБРАТЬ РАЗРЕШЕННЫЕ " + ТекстВыбрать + "
	| Справочник_ДемоКонтактныеЛицаПартнеров.Ссылка,
	| Справочник_ДемоКонтактныеЛицаПартнеров.Наименование
	| ИЗ Справочник._ДемоКонтактныеЛицаПартнеров КАК Справочник_ДемоКонтактныеЛицаПартнеров " + ТекстИз + ТекстГде;
	
КонецПроцедуры


#КонецОбласти